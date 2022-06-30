import 'package:accountsapp/Data/Model/account_model.dart';
import 'package:accountsapp/Data/Repository/Accounts/accounts_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Modules/Home/Events/home_screen_events.dart';
import '../../Modules/Home/Screens/home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState()) {
    on<LoadData>(_loadData);
  }

  //? Load Bank Account Details Initially
  _loadData(LoadData event, Emitter<HomeScreenState> emit) async {
    var accountDetails = Accounts().getAllAccountDetails();
    var accountModelList = [];

    for (var account in accountDetails) {
      AccountModel model = AccountModel(
        userId: account["userId"],
        name: account["name"],
        logo: account["logo"],
        accountType: account["accountType"],
        accountNumber: account["accountNumber"],
        balance: account["balance"],
      );

      accountModelList.add(model);
    }

    emit(state.copyWith(accounts: accountModelList));
  }
}
