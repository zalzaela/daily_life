import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Spending extends StatefulWidget {
  @override
  _SpendingState createState() => _SpendingState();
}

class _SpendingState extends State<Spending> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference spendingColReff = firestore.collection("spending");
    
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: spendingColReff.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs.map((e) {
                    DateTime convertToDate = new DateFormat("yyyy-MM-dd").parse(e.data()['date']);
                    String displayDate = new DateFormat("dd MMMM yyyy").format(convertToDate);
                    return Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "account: " + e.data()['account'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            "amount: "+e.data()['amount'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            "category: "+e.data()['category'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            "date: "+displayDate,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            "note: "+e.data()['note'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Text("Loading");
              }
            },
          ),
        ],
      ),
    );
  }
}
