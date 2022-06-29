import 'package:accountsapp/Data/Model/account_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

abstract class TransactionScreenEvent {}

// Load Transactions Data corresponding to a particular account
class LoadData extends TransactionScreenEvent {
  AccountModel model;
  LoadData({required this.model});
}

// Change Slider Range Values
class UpdateSliderRanges extends TransactionScreenEvent {
  SfRangeValues value;
  UpdateSliderRanges({required this.value});
}
