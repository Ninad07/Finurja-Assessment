class TransactionModel {
  String userId;
  String name;
  String logo;
  String accountType;
  String accountNumber;
  String balance;
  Map<String, List<Map>> transactions;

  TransactionModel({
    this.userId = "null",
    this.name = "Name",
    this.logo = "null",
    this.accountType = "Current A/C",
    this.accountNumber = "0123456789",
    this.balance = "0.0",
    this.transactions = const {},
  });
}
