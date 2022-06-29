import 'package:accountsapp/Data/Model/transaction_model.dart';

class TransactionScreenState {
  TransactionModel transactionModel;
  TransactionScreenState({
    required this.transactionModel,
  });

  TransactionScreenState copyWith({var transactionModel}) {
    return TransactionScreenState(
      transactionModel: transactionModel ?? this.transactionModel,
    );
  }
}
