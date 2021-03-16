part of 'list_account_view.dart';

class ItemAccountView extends StatelessWidget {
  final GestureTapCallback onTap;
  final AccountModel accountModel;

  ItemAccountView({
    Key key,
    @required this.onTap,
    @required this.accountModel,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.wallet,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                    SizedBox(width: 10),
                    Text(
                      accountModel.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.columns,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                    SizedBox(width: 10),
                    Text(
                      accountModel.type,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              child: Text(
                NumberFormat.currency(
                        locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                    .format(accountModel.balance),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  decoration: TextDecoration.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
