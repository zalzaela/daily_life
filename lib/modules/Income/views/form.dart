import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              "Form Income",
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
                      debugPrint("Save Items");
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
            Container(
              color: Colors.grey,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Date"),
              ),
            ),
            Container(
              color: Colors.grey,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Account"),
              ),
            ),
            Container(
              color: Colors.grey,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Category"),
              ),
            ),
            Container(
              color: Colors.grey,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Amount"),
              ),
            ),
            Container(
              color: Colors.grey,
              height: 100,
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
