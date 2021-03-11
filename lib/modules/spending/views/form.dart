import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/global/repository.dart';
import 'package:daily_life/modules/spending/models/spendingModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SpendingForm extends StatefulWidget {
  final String id;
  SpendingForm({this.id});

  @override
  _SpendingFormState createState() => _SpendingFormState();
}

class _SpendingFormState extends State<SpendingForm> {
  Future<SpendingModel> _spendingStream;
  Future _updateSpending;
  Future _addSpending;

  @override
  void initState() {
    super.initState();
    if (this.widget.id != '') {
      _spendingStream =
          context.read<Repository>().getSpendingById(this.widget.id);
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime _selectedDate;
  String _accountName;
  String _categoryName;

  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference accountColReff = firestore.collection("account");
  CollectionReference spendingColReff = firestore.collection("spending");
  CollectionReference categoryColReff = firestore.collection("category");

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      DateTime newSelectedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2040),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  surface: Colors.grey[300],
                  onSurface: Colors.grey[800],
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child,
            );
          });

      if (newSelectedDate != null) {
        _selectedDate = newSelectedDate;
        dateController
          ..text = new DateFormat("dd MMMM yyyy").format(_selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: dateController.text.length,
              affinity: TextAffinity.upstream));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Form Spending",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontFamily: "Roboto-Regular",
              ),
            ),
            Container(
              child: Row(
                children: [
                  if (this.widget.id != '') ...[
                    GestureDetector(
                      onTap: () async {
                        spendingColReff.doc(this.widget.id).delete();
                        Navigator.of(context).pop();
                      },
                      child: FaIcon(
                        FontAwesomeIcons.solidTrashAlt, // solidSave,
                        color: Colors.red[800],
                        size: 24,
                      ),
                    )
                  ] else ...[
                    Center()
                  ]
                ],
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder<SpendingModel>(
          future: _spendingStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return buildLoading();
              default:
                if (snapshot.hasData) {
                  DateTime convertToDate =
                      new DateFormat("yyyy-MM-dd").parse(snapshot.data.date);
                  _selectedDate = convertToDate;
                  _accountName = snapshot.data.account;
                  _categoryName = snapshot.data.category;
                  amountController.text = snapshot.data.amount.toString();
                  dateController.text =
                      new DateFormat("dd MMMM yyyy").format(convertToDate);
                  // amountController.text = NumberFormat.currency(
                  //         locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  //     .format(snapshot.data.amount);
                  noteController.text = snapshot.data.note;
                }
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green[300], spreadRadius: 3),
                          ],
                        ),
                        height: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: TextField(
                            onTap: () => _selectDate(context),
                            focusNode: AlwaysDisabledFocusNode(),
                            controller: dateController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration.collapsed(
                                hintText: "Select Date"),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green[300], spreadRadius: 3),
                          ],
                        ),
                        height: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: FutureBuilder<QuerySnapshot>(
                            future: accountColReff.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButtonFormField(
                                  value: _accountName,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Select Account'),
                                  icon: FaIcon(FontAwesomeIcons.sortDown),
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String newValue) {
                                    _accountName = newValue;
                                  },
                                  items: snapshot.data.docs
                                      .map((DocumentSnapshot documentSnapshot) {
                                    return DropdownMenuItem<String>(
                                        value: documentSnapshot.data()['name'],
                                        child: Text(
                                            documentSnapshot.data()['name']));
                                  }).toList(),
                                );
                              } else {
                                return buildLoading();
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green[300], spreadRadius: 3),
                          ],
                        ),
                        height: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: FutureBuilder<QuerySnapshot>(
                            future: categoryColReff.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButtonFormField(
                                  value: _categoryName,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Select Account'),
                                  icon: FaIcon(FontAwesomeIcons.sortDown),
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String newValue) {
                                    _categoryName = newValue;
                                  },
                                  items: snapshot.data.docs
                                      .map((DocumentSnapshot documentSnapshot) {
                                    return DropdownMenuItem<String>(
                                        value: documentSnapshot.data()['name'],
                                        child: Text(
                                            documentSnapshot.data()['name']));
                                  }).toList(),
                                );
                              } else {
                                return buildLoading();
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green[300], spreadRadius: 3),
                          ],
                        ),
                        height: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: TextField(
                            onSubmitted: (val) {
                              // amountController.text = NumberFormat.currency(
                              //         locale: 'id',
                              //         symbol: 'Rp. ',
                              //         decimalDigits: 0)
                              //     .format(double.parse(val))
                              //     .toString();
                            },
                            controller: amountController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration.collapsed(hintText: "Amount"),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green[300], spreadRadius: 3),
                          ],
                        ),
                        height: 70,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: noteController,
                          decoration:
                              InputDecoration.collapsed(hintText: "Note"),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                      TextButton(
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue[600],
                          ),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Roboto-Regular",
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          var user = FirebaseAuth.instance.currentUser;
                          String date = new DateFormat("yyyy-MM-dd")
                              .format(_selectedDate);
                          SpendingModel spendingModel = new SpendingModel(
                              this.widget.id,
                              _accountName,
                              int.parse(amountController.text),
                              _categoryName,
                              date,
                              noteController.text,
                              user.uid);

                          if (this.widget.id != '') {
                            _updateSpending = context
                                .read<Repository>()
                                .updateSpending(this.widget.id, spendingModel);
                          } else {
                            _addSpending = context
                                .read<Repository>()
                                .addSpending(spendingModel);
                          }

                          Navigator.of(context).pop();
                          // Navigator.pushReplacementNamed(context, '/main');
                          // Routes.router.navigateTo(context, "/main", transition: TransitionType.material);
                        },
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
