import 'package:accountsapp/Data/Model/account_model.dart';

abstract class TransactionScreenEvent {}

// Load Transactions Data corresponding to a particular account
class LoadData extends TransactionScreenEvent {
  AccountModel model;
  LoadData({required this.model});
}
