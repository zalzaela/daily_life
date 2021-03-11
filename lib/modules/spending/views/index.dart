import 'package:daily_life/modules/global/repository.dart';
import 'package:daily_life/modules/spending/models/spendingModel.dart';
import 'package:daily_life/routes/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Spending extends StatefulWidget {
  @override
  _SpendingState createState() => _SpendingState();
}

class _SpendingState extends State<Spending> {
  Stream<List<SpendingModel>> _spendingStream;

  @override
  void initState() {
    super.initState();
    _spendingStream = context.read<Repository>().getSpending();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<List<SpendingModel>>(
        stream: _spendingStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return buildLoading();
            default:
              return ListView(
                children: snapshot.data.map((SpendingModel spendingModel) {
                  DateTime convertToDate =
                      new DateFormat("yyyy-MM-dd").parse(spendingModel.date);
                  String displayDate =
                      new DateFormat("dd MMMM yyyy").format(convertToDate);
                  return GestureDetector(
                    onTap: () {
                      Routes.router.navigateTo(
                          context, "/spending/form/${spendingModel.id}",
                          transition: TransitionType.material);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.fromLTRB(20, 7, 20, 7),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.blue[300], spreadRadius: 3),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.wallet,
                                    color: Colors.grey[600],
                                    size: 14,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    spendingModel.account,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp. ',
                                        decimalDigits: 0)
                                    .format(spendingModel.amount),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.columns,
                                    color: Colors.grey[600],
                                    size: 14,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    spendingModel.category,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                displayDate,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
