class TransactionScreenState {
  var transactions;
  TransactionScreenState({
    this.transactions,
  });

  TransactionScreenState copyWith(var transactions) {
    return TransactionScreenState(
      transactions: transactions ?? this.transactions,
    );
  }
}
