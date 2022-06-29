import 'package:accountsapp/Data/Model/transaction_model.dart';
import 'package:accountsapp/Data/Repository/Transactions/transactions_data.dart';
import 'package:flutter/material.dart';

import '../../Modules/Transactions/Events/transaction_screen_events.dart';
import '../../Modules/Transactions/Screens/transactions_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreenBloc
    extends Bloc<TransactionScreenEvent, TransactionScreenState> {
  TransactionScreenBloc()
      : super(TransactionScreenState(transactionModel: TransactionModel())) {
    on<LoadData>(_loadData);
  }

  // Load Transactions of a particular user
  _loadData(LoadData event, Emitter<TransactionScreenState> emit) {
    var transactionsList =
        Transactions().getTransactionsList(event.model.userId);
    // Build the model
    TransactionModel model = TransactionModel(
      userId: event.model.userId,
      name: event.model.name,
      accountNumber: event.model.accountNumber,
      accountType: event.model.accountType,
      balance: event.model.balance,
      logo: event.model.logo,
    );

    Map<String, List<Map>> transactionsMap = {};

    for (var transaction in transactionsList) {
      transactionsMap.putIfAbsent(transaction["date"], () => []);
      transactionsMap[transaction["date"]]!.add(transaction);
    }

    model.transactions = transactionsMap;

    // Build the dates and Widgets list for later convinience in filtering
    // Retireve all dates from the map
    var datesList = [];
    var mapToWidget = {};
    for (String key in model.transactions.keys) {
      datesList.add(key);
    }

    datesList.sort(((a, b) => b.compareTo(a)));

    // For building a Map of List which stores the list of widgets storing transaction details to be displayed on accordance with particular dates
    for (String date in datesList) {
      List<Widget> widgetsList = [];
      for (var transaction in model.transactions[date]!) {
        var dataWidget = Container(
            margin: const EdgeInsets.only(left: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction["recipient"],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rs ${transaction["amount"]}",
                      style: TextStyle(
                        color:
                            transaction["credit"] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      transaction["credit"]
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction["credit"] ? Colors.green : Colors.red,
                      size: 15,
                    )
                  ],
                ),
              ],
            ));

        widgetsList.add(dataWidget);
        widgetsList.add(const SizedBox(height: 15));
      }

      widgetsList.add(const SizedBox(height: 10));
      mapToWidget[date] = widgetsList;
    }

    emit(state.copyWith(
        transactionModel: model,
        datesList: datesList,
        mapToWidget: mapToWidget));
  }
}
