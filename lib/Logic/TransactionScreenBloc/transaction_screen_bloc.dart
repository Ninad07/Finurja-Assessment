import 'dart:collection';

import 'package:accountsapp/Data/Model/transaction_model.dart';
import 'package:accountsapp/Data/Repository/Transactions/transactions_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../Modules/Transactions/Events/transaction_screen_events.dart';
import '../../Modules/Transactions/Screens/transactions_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreenBloc
    extends Bloc<TransactionScreenEvent, TransactionScreenState> {
  TransactionScreenBloc()
      : super(TransactionScreenState(transactionModel: TransactionModel())) {
    on<LoadData>(_loadData);
    on<UpdateSliderRanges>(_updateSliderRanges);
    on<UpdateCreditFilterValue>(_updateCreditFilterValue);
    on<UpdateDebitFilterValue>(_updateDebitFilterValue);
    on<ToggleTransactionDateFilterValue>(_toggleTransactionDateFilterValue);
    on<ResetFilters>(_resetFilters);
    on<ApplyFilters>(_applyFilters);
  }

  //? Apply All Filters
  _applyFilters(ApplyFilters event, Emitter<TransactionScreenState> emit) {
    var datesList = [];
    LinkedHashMap mapToWidget = LinkedHashMap();
    for (String key in state.transactionModel.transactions.keys) {
      datesList.add(key);
    }

    // Oldest To Latest Filter Selected
    if (!state.latestToOldest) {
      datesList.sort(((a, b) => a.compareTo(b)));

      // Latest To Oldest Filter Selected
    } else {
      datesList.sort(((a, b) => b.compareTo(a)));
    }

    // For Sorting on the basis of filters
    LinkedHashMap<String, List> transactionDataMap = LinkedHashMap();
    for (String date in datesList) {
      List<List> transactionDataList = [];
      for (var transaction in state.transactionModel.transactions[date]!) {
        var list = [
          transaction["recipient"],
          transaction["amount"],
          transaction["credit"] ? "2" : "1", // For the sake of sorting
        ];

        // If Amount range filter is used
        if ((state.startAmount > 0 || state.endAmount < 100000)) {
          if (double.parse(transaction["amount"]) >= state.startAmount &&
              double.parse(transaction["amount"]) <= state.endAmount) {
            transactionDataList.add(list);
          }
        } else {
          transactionDataList.add(list);
        }
      }

      if (transactionDataList.isNotEmpty) {
        if (state.credit != state.debit) {
          // Credit Filter
          if (state.credit) {
            transactionDataList.sort(((a, b) => b[2].compareTo(a[2])));

            // Debit Filter
          } else {
            transactionDataList.sort(((a, b) => a[2].compareTo(b[2])));
          }
        }

        transactionDataMap.putIfAbsent(date, () => []);
        transactionDataMap[date] = transactionDataList;
      }
    }

    // Update the datesList after the filtering is done
    datesList.clear();

    // Building the Widgets Map for Displaying on the interface
    for (String date in transactionDataMap.keys) {
      if (transactionDataMap[date] == null) continue;

      List<Widget> widgetsList = [];
      for (var transaction in transactionDataMap[date]!) {
        var dataWidget = Container(
            margin: const EdgeInsets.only(left: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rs ${transaction[1]}",
                      style: TextStyle(
                        color:
                            transaction[2] == "2" ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      transaction[2] == "2"
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction[2] == "2" ? Colors.green : Colors.red,
                      size: 15,
                    )
                  ],
                ),
              ],
            ));

        datesList.add(date);
        widgetsList.add(dataWidget);
        widgetsList.add(const SizedBox(height: 15));
      }

      widgetsList.add(const SizedBox(height: 10));
      mapToWidget[date] = widgetsList;
    }

    emit(state.copyWith(datesList: datesList, mapToWidget: mapToWidget));
  }

  //? Reset All Filters
  _resetFilters(ResetFilters event, Emitter<TransactionScreenState> emit) {
    emit(
      state.copyWith(
          latestToOldest: true,
          credit: false,
          debit: false,
          startAmount: 0,
          endAmount: 100000,
          values: const SfRangeValues(0, 100000)),
    );
  }

  //? Toggle Transaction Date Filter Value Event
  _toggleTransactionDateFilterValue(ToggleTransactionDateFilterValue event,
      Emitter<TransactionScreenState> emit) {
    emit(state.copyWith(latestToOldest: !state.latestToOldest));
  }

  //? Update Credit Filter Value
  _updateCreditFilterValue(
      UpdateCreditFilterValue event, Emitter<TransactionScreenState> emit) {
    emit(state.copyWith(credit: !state.credit));
  }

  //? Update Debit Filter Value
  _updateDebitFilterValue(
      UpdateDebitFilterValue event, Emitter<TransactionScreenState> emit) {
    emit(state.copyWith(debit: !state.debit));
  }

  //? Load Transactions of a particular user
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

  //? Update Slider Ranges
  _updateSliderRanges(
      UpdateSliderRanges event, Emitter<TransactionScreenState> emit) {
    emit(state.copyWith(
        values: event.value,
        startAmount: (event.value.start).round(),
        endAmount: (event.value.end).round()));
  }
}
