class HomeScreenState {
  List accounts;
  HomeScreenState({
    this.accounts = const [],
  });

  HomeScreenState copyWith({var accounts}) {
    return HomeScreenState(
      accounts: accounts ?? this.accounts,
    );
  }

  getAccountDetails() async {
    return accounts;
  }
}
