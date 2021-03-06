import 'package:accountsapp/Data/Model/transaction_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TransactionScreenState {
  TransactionModel transactionModel;
  var datesList;
  var mapToWidget;
  bool latestToOldest, amountBetween, credit, debit;
  int startAmount, endAmount;
  SfRangeValues values;
  TransactionScreenState({
    required this.transactionModel,
    this.latestToOldest = true,
    this.credit = false,
    this.debit = false,
    this.amountBetween = false,
    this.datesList = const [],
    this.mapToWidget = const [],
    this.startAmount = 0,
    this.endAmount = 100000,
    this.values = const SfRangeValues(0, 100000),
  });

  TransactionScreenState copyWith({
    var transactionModel,
    var datesList,
    var mapToWidget,
    var latestToOldest,
    var credit,
    var debit,
    var amountBetween,
    var startAmount,
    var endAmount,
    var values,
  }) {
    return TransactionScreenState(
      transactionModel: transactionModel ?? this.transactionModel,
      datesList: datesList ?? this.datesList,
      mapToWidget: mapToWidget ?? this.mapToWidget,
      latestToOldest: latestToOldest ?? this.latestToOldest,
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
      amountBetween: amountBetween ?? this.amountBetween,
      startAmount: startAmount ?? this.startAmount,
      endAmount: endAmount ?? this.endAmount,
      values: values ?? this.values,
    );
  }
}
