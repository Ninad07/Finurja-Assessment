import 'package:accountsapp/Data/Model/transaction_model.dart';
import 'package:accountsapp/Data/Repository/Transactions/transactions_data.dart';

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
    print(model.accountNumber);

    model.transactions = transactionsMap;
    emit(state.copyWith(transactionModel: model));
  }
}
