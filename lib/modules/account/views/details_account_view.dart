part of 'list_account_view.dart';

class DetailsAccountView extends StatelessWidget {
  final String id;

  DetailsAccountView({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        final account = (state as AccountLoaded)
            .accountModel
            .firstWhere((account) => account.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Account Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Account',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<AccountBloc>(context).add(DeleteAccount(account));
                  Navigator.pop(context, account);
                },
              )
            ],
          ),
          body: account == null
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
                                  tag: '${account.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      account.name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  account.balance.toString(),
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
            tooltip: 'Edit Account',
            child: Icon(Icons.edit),
            onPressed: account == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FormAccountView(
                            onSave: (name, balance, type) {
                              BlocProvider.of<AccountBloc>(context).add(
                                UpdateAccount(
                                  account.copyWith(
                                      name: name,
                                      balance: balance,
                                      type: type),
                                ),
                              );
                            },
                            isEditing: true,
                            accountModel: account,
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
