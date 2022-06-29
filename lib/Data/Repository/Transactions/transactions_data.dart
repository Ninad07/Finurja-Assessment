// Dummy Data
// Transactions details of individual users, distinguished by user ids
class Transactions {
  var transactions = {
    "0": [
      {
        "date": "08/07/2020",
        "recipient": "PGVCL Electricity Bill",
        "amount": "2500.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "25000.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "12000.00",
        "credit": true,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "3000.00",
        "credit": true,
      },
      {
        "date": "12/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "35000.00",
        "credit": false,
      },
      {
        "date": "13/07/2020",
        "recipient": "ATM Deposit",
        "amount": "50000.00",
        "credit": true,
      },
    ],
    "1": [
      {
        "date": "08/07/2020",
        "recipient": "PGVCL Electricity Bill",
        "amount": "2500.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "25000.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "12000.00",
        "credit": true,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "3000.00",
        "credit": true,
      },
      {
        "date": "12/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "35000.00",
        "credit": false,
      },
      {
        "date": "13/07/2020",
        "recipient": "ATM Deposit",
        "amount": "50000.00",
        "credit": true,
      },
    ],
    "2": [
      {
        "date": "08/07/2020",
        "recipient": "PGVCL Electricity Bill",
        "amount": "2500.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "25000.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "12000.00",
        "credit": true,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "3000.00",
        "credit": true,
      },
      {
        "date": "12/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "35000.00",
        "credit": false,
      },
      {
        "date": "13/07/2020",
        "recipient": "ATM Deposit",
        "amount": "50000.00",
        "credit": true,
      },
    ],
    "3": [
      {
        "date": "08/07/2020",
        "recipient": "PGVCL Electricity Bill",
        "amount": "2500.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "25000.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "12000.00",
        "credit": true,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "3000.00",
        "credit": true,
      },
      {
        "date": "12/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "35000.00",
        "credit": false,
      },
      {
        "date": "13/07/2020",
        "recipient": "ATM Deposit",
        "amount": "50000.00",
        "credit": true,
      },
    ],
    "4": [
      {
        "date": "08/07/2020",
        "recipient": "PGVCL Electricity Bill",
        "amount": "2500.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "25000.00",
        "credit": false,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "12000.00",
        "credit": true,
      },
      {
        "date": "10/07/2020",
        "recipient": "ATM Deposit",
        "amount": "3000.00",
        "credit": true,
      },
      {
        "date": "12/07/2020",
        "recipient": "ATM Withdrawl",
        "amount": "35000.00",
        "credit": false,
      },
      {
        "date": "13/07/2020",
        "recipient": "ATM Deposit",
        "amount": "50000.00",
        "credit": true,
      },
    ],
  };

  getTransactionsList(String userId) {
    return transactions[userId] ?? [];
  }
}
