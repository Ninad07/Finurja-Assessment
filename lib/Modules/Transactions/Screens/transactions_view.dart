import 'package:accountsapp/Data/Model/account_model.dart';
import 'package:accountsapp/Modules/Transactions/Screens/transactions_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Data/Model/transaction_model.dart';
import '../../../Logic/TransactionScreenBloc/transaction_screen_bloc.dart';
import '../Events/transaction_screen_events.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({Key? key, this.model}) : super(key: key);
  final model;

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  void initState() {
    _changeStatusbarColor();

    // Load Transactions Details
    context.read<TransactionScreenBloc>().add(LoadData(model: widget.model));
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
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
        title: const Text("Transactions"),
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

  // Scaffold body
  Widget _body() {
    return BlocBuilder<TransactionScreenBloc, TransactionScreenState>(
      builder: (context, state) {
        TransactionModel model = state.transactionModel;
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                constraints: BoxConstraints(
                  minHeight: 130,
                  maxWidth: MediaQuery.of(context).size.width - 20,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300))),
                child: Column(
                  children: [
                    _getLogoNameBalanceDetails(model),
                    const SizedBox(height: 10),
                    _getAccountTypeNumberDetails(model),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _getFilterWidget(state),
              const SizedBox(height: 10),
              _getTransactionsData(model, state, context),
            ],
          ),
        );
      },
    );
  }

  // Filter Widget
  _getFilterWidget(TransactionScreenState state) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 130,
      ),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const SizedBox(),
              SizedBox(
                child: Text(
                  "Last 10 Transactions",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        builder: (BuildContext context) {
                          return _filterWindow(context);
                        });
                  },
                  icon: Icon(
                    Icons.filter_alt,
                    color: Colors.grey.shade800,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  //? Filter Window
  Widget _filterWindow(BuildContext context) {
    return BlocBuilder<TransactionScreenBloc, TransactionScreenState>(
        builder: (context, state) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                )),
                child: const Text(
                  "Sort & Filter",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sort By Time",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Checkbox(
                      value: state.latestToOldest,
                      activeColor: Colors.blue.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onChanged: (val) {},
                    ),
                    const SizedBox(width: 5),
                    const Text("Latest To Oldest"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Checkbox(
                      value: !state.latestToOldest,
                      activeColor: Colors.blue.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onChanged: (val) {},
                    ),
                    const SizedBox(width: 5),
                    const Text("Oldest To Latest"),
                  ],
                ),
              ),

              // Filter By
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Filter By",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Checkbox(
                      value: state.credit,
                      activeColor: Colors.blue.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (val) {},
                    ),
                    const SizedBox(width: 5),
                    const Text("Credit"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Checkbox(
                      value: state.debit,
                      activeColor: Colors.blue.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (val) {},
                    ),
                    const SizedBox(width: 5),
                    const Text("Debit"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Checkbox(
                      value: !(state.startAmount == 0 &&
                          state.endAmount == 100000),
                      activeColor: Colors.blue.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (val) {},
                    ),
                    const SizedBox(width: 5),
                    Text(
                        "Amount Between ${state.startAmount} and ${state.endAmount == 100000 ? "1L+" : state.endAmount}"),
                  ],
                ),
              ),

              const SizedBox(height: 45),
              _getRangeSliderWidget(),
            ],
          ),
        ),
      );
    });
  }

  //? Range Slider
  Widget _getRangeSliderWidget() {
    return BlocBuilder<TransactionScreenBloc, TransactionScreenState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: SfRangeSliderTheme(
            data: SfRangeSliderThemeData(
              tooltipBackgroundColor: Colors.blue.shade800,
            ),
            child: SfRangeSlider(
              values: state.values,
              min: 0,
              max: 100000,
              interval: 1000,
              stepSize: 1000,
              enableTooltip: true,
              shouldAlwaysShowTooltip: true,
              tooltipShape: const SfPaddleTooltipShape(),
              activeColor: Colors.blue.shade800,
              onChanged: (dynamic value) {
                context
                    .read<TransactionScreenBloc>()
                    .add(UpdateSliderRanges(value: value));
              },
            ),
          ),
        );
      },
    );
  }

  //? Transactions Data
  Widget _getTransactionsData(TransactionModel model,
      TransactionScreenState state, BuildContext context) {
    var datesList = state.datesList;
    var mapToWidget = state.mapToWidget;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        height: MediaQuery.of(context).size.height,
        // color: Colors.grey,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: datesList.length,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 80,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blue,
                    child: Column(
                      children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                datesList[index],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ] +
                          mapToWidget[datesList[index]],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            }),
      ),
    );
  }

  //? Logo Name and Balance Details
  Widget _getLogoNameBalanceDetails(TransactionModel model) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                height: 25,
                width: 25,
                child: Image(image: AssetImage(model.logo)),
              ),
              const SizedBox(width: 15),
              Text(model.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ],
          ),
          Text(
            "Rs ${model.balance}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  //? Account Type and Account Number
  Widget _getAccountTypeNumberDetails(TransactionModel model) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Text(
            model.accountType,
            style: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "(XX${model.accountNumber.substring(model.accountNumber.length - 4)})",
            style: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            "2.5% p.a.",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
