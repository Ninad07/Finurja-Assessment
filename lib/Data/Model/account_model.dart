class AccountModel {
  String userId;
  String name;
  String logo;
  String accountType;
  String accountNumber;
  String balance;

  AccountModel({
    this.userId = "null",
    this.name = "Name",
    this.logo = "null",
    this.accountType = "Current A/C",
    this.accountNumber = "0123456789",
    this.balance = "0.0",
  });
}
