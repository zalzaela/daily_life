part of 'list_spending_view.dart';

class ItemSpendingView extends StatelessWidget {
  final GestureTapCallback onTap;
  final SpendingModel spendingModel;

  ItemSpendingView({
    Key key,
    @required this.onTap,
    @required this.spendingModel,
  }) : super(key: key);

  String readTimestamp(Timestamp timestamp) {
    var format = DateFormat('dd MMMM yyyy');
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                          locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
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
                  readTimestamp(spendingModel.date),
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
  }
}
