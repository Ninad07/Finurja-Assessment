// Dummy Data
// Contains information about a few user accounts
class Accounts {
  var accounts = [
    {
      "userId": "0",
      "name": "HDFC Bank",
      "logo": "assets/images/hdfc_logo.png",
      "accountType": "Savings A/C",
      "accountNumber": "123456789",
      "balance": "54,000",
    },
    {
      "userId": "1",
      "name": "Federal Bank",
      "logo": "assets/images/federal_logo.jpg",
      "accountType": "Current A/C",
      "accountNumber": "024652132",
      "balance": "1,00,000",
    },
    {
      "userId": "2",
      "name": "Axis Bank",
      "logo": "assets/images/axis_logo.jpg",
      "accountType": "Savings A/C",
      "accountNumber": "123456789",
      "balance": "70,000",
    },
    {
      "userId": "3",
      "name": "ICICI Bank",
      "logo": "assets/images/icici_logo.png",
      "accountType": "Savings A/C",
      "accountNumber": "123456789",
      "balance": "35,000",
    },
    {
      "userId": "4",
      "name": "State Bank",
      "logo": "assets/images/sbi_logo.png",
      "accountType": "Savings A/C",
      "accountNumber": "123456789",
      "balance": "50,000",
    },
  ];

  getAccountDetails(int index) {
    return accounts[index];
  }

  getAllAccountDetails() {
    return accounts;
  }
}
