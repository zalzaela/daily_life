part of 'list_spending_view.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpendingBloc, SpendingState>(
      builder: (context, state) {
        final spending = (state as SpendingLoaded)
            .spendingModel
            .firstWhere((spending) => spending.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Spending Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Spending',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<SpendingBloc>(context).add(DeleteSpending(spending));
                  Navigator.pop(context, spending);
                },
              )
            ],
          ),
          body: spending == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Container()),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${spending.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      spending.account,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  spending.note,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Spending',
            child: Icon(Icons.edit),
            onPressed: spending == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FormSpendingView(
                            onSave: (accountId, accountName, amount, category, date, note) {
                              BlocProvider.of<SpendingBloc>(context).add(
                                UpdateSpending(
                                  spending.copyWith(
                                      accountId: accountId,
                                      account: accountName,
                                      amount: amount,
                                      category: category,
                                      date: date,
                                      note: note),
                                ),
                              );
                            },
                            isEditing: true,
                            spendingModel: spending,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
