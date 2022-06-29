import 'package:accountsapp/Data/Model/account_model.dart';
import 'package:accountsapp/Logic/TransactionScreenBloc/transaction_screen_bloc.dart';
import 'package:accountsapp/Modules/Home/Events/home_screen_events.dart';
import 'package:accountsapp/Modules/Transactions/Screens/transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../Logic/HomeScreenBloc/home_screen_bloc.dart';
import 'home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _changeStatusbarColor();
    // Load accounts data
    context.read<HomeScreenBloc>().add(LoadData());
    super.initState();
  }

  // Change Status Bar Color Immediately after the activity launches
  _changeStatusbarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade900);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text("All Bank Accounts"),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  // Scaffold Body
  Widget _body() {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        // Get List of Account Models loaded initially
        List accountModelList = state.accounts;
        return SizedBox(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: accountModelList.length,
            itemBuilder: (context, int index) {
              AccountModel model = accountModelList[index];
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxWidth: MediaQuery.of(context).size.width - 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),

                        // Logo and Name
                        _getLogoNameDetails(model),

                        const SizedBox(
                          height: 25,
                        ),

                        // Account Number and Balance
                        _getAccountNumberBalanceDetails(model),

                        const SizedBox(
                          height: 25,
                        ),

                        // View Transactions
                        _getTransactionDetailsButton(model),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // Returns Logo Image and Bank Name Wrapped in a widget
  Widget _getLogoNameDetails(AccountModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 5),
        SizedBox(
          height: 30,
          width: 30,
          child: Image(image: AssetImage(model.logo)),
        ),
        const SizedBox(width: 15),
        Text(model.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      ],
    );
  }

  // Returns Account Number, Account Type and Account Balance wrapped in a Widget
  Widget _getAccountNumberBalanceDetails(AccountModel model) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.accountType,
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "XX${model.accountNumber.substring(model.accountNumber.length - 4)}",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Your Balance",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Rs ${model.balance}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // View Transactions Button
  Widget _getTransactionDetailsButton(AccountModel model) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransactionsView(
              model: model,
            );
          }));
        },
        child: Text(
          "View Transactions",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue.shade600,
          ),
        ),
      ),
    );
  }
}
