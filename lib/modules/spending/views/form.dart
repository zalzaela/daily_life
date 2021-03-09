import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SpendingForm extends StatefulWidget {
  @override
  _SpendingFormState createState() => _SpendingFormState();
}

class _SpendingFormState extends State<SpendingForm> {
  DateTime selectedDate = DateTime.now();
  String displayDate = "Select Date";
  String accountName;
  String categoryName;

  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference accountColReff = firestore.collection("account");
    CollectionReference spendingColReff = firestore.collection("spending");
    CollectionReference categoryColReff = firestore.collection("category");

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          displayDate = DateFormat("dd MMMM yyyy").format(picked);
        });
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
                  GestureDetector(
                    onTap: () {
                      var user = FirebaseAuth.instance.currentUser;
                      String date = new DateFormat("yyyy-MM-dd").format(selectedDate);
                      spendingColReff.add({
                        'account': accountName,
                        'amount': int.parse(amountController.text),
                        'category': categoryName,
                        'date': date,
                        'note': noteController.text,
                        'uid': user.uid,
                      });

                      Routes.router.navigateTo(context, "/main", transition: TransitionType.material);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.solidSave,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                color: Colors.grey,
                height: 50,
                margin: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    displayDate,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
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
                        value: accountName,
                        hint: Text("Select Account"),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        icon: FaIcon(FontAwesomeIcons.longArrowAltDown),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            accountName = newValue;
                          });
                        },
                        items: snapshot.data.docs
                            .map((DocumentSnapshot documentSnapshot) {
                          return DropdownMenuItem<String>(
                              value: documentSnapshot.data()['name'],
                              child: Text(documentSnapshot.data()['name']));
                        }).toList(),
                      );
                    } else {
                      return Text("Loading");
                    }
                  },
                ),
              ),
            ),
            Container(
              color: Colors.grey,
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
                        value: categoryName,
                        hint: Text("Select Category"),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        icon: FaIcon(FontAwesomeIcons.longArrowAltDown),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            categoryName = newValue;
                          });
                        },
                        items: snapshot.data.docs
                            .map((DocumentSnapshot documentSnapshot) {
                          return DropdownMenuItem<String>(
                              value: documentSnapshot.data()['name'],
                              child: Text(documentSnapshot.data()['name']));
                        }).toList(),
                      );
                    } else {
                      return Text("Loading");
                    }
                  },
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: TextField(
                  controller: amountController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: "Amount"),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              height: 100,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: noteController,
                decoration: InputDecoration.collapsed(hintText: "Note"),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
