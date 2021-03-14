part of 'list_income_view.dart';

class DetailsIncomeView extends StatelessWidget {
  final String id;

  DetailsIncomeView({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeBloc, IncomeState>(
      builder: (context, state) {
        final income = (state as IncomeLoaded)
            .incomeModel
            .firstWhere((income) => income.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Income Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Income',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<IncomeBloc>(context)
                      .add(DeleteIncome(income));
                  Navigator.pop(context, income);
                },
              )
            ],
          ),
          body: income == null
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
                                  tag: '${income.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      income.account,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  income.note,
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
            tooltip: 'Edit Income',
            child: Icon(Icons.edit),
            onPressed: income == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FormIncomeView(
                            onSave: (account, amount, category, date, note) {
                              BlocProvider.of<IncomeBloc>(context).add(
                                UpdateIncome(
                                  income.copyWith(
                                      account: account,
                                      amount: amount,
                                      category: category,
                                      date: date,
                                      note: note),
                                ),
                              );
                            },
                            isEditing: true,
                            incomeModel: income,
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
