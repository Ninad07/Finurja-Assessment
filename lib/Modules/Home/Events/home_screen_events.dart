abstract class HomeScreenEvent {}

// Load Accounts Data Initially
class LoadData extends HomeScreenEvent {}

// View Transactions
class ViewTransactions extends HomeScreenEvent {
  var index;
  ViewTransactions({required this.index});
}
