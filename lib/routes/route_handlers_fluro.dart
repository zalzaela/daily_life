part of 'app_fluro.dart';

var authHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: Center(
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailiure) {
            print('Undefined state : ${state.runtimeType}');
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationStarted());
            return CircularProgressIndicator();
          } else if (state is AuthenticationLoading) {
            return CircularProgressIndicator();
          } else if (state is AuthenticationSuccess) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<TabBloc>(
                  create: (context) => TabBloc(),
                ),
              ],
              child: MainView(),
            );
          }

          print('Undefined state : ${state.runtimeType}');
          return LoginView();
        },
      ),
    ),
  );
});

var spendingFromHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return FormSpendingView(
    onSave: (account, amount, category, date, note) {
      BlocProvider.of<SpendingBloc>(context).add(
        AddSpending(
          SpendingModel(
              account: account,
              amount: amount,
              category: category,
              date: date,
              note: note),
        ),
      );
    },
    isEditing: false,
  );
});

var incomeFromHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return FormIncomeView(
    onSave: (account, amount, category, date, note) {
      BlocProvider.of<IncomeBloc>(context).add(
        AddIncome(
          IncomeModel(
              account: account,
              amount: amount,
              category: category,
              date: date,
              note: note),
        ),
      );
    },
    isEditing: false,
  );
});

var accountHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ListViewAccount();
});

var accountFromHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return FormAccountView(
    onSave: (name, balance, type) {
      BlocProvider.of<AccountBloc>(context).add(
        AddAccount(AccountModel(name: name, balance: balance, type: type)),
      );
    },
    isEditing: false,
  );
});

var categoryHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ListViewCategory();
});

var categoryFromHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return FormCategoryView(
    onSave: (name, type) {
      BlocProvider.of<CategoryBloc>(context).add(
        AddCategory(CategoryModel(name: name, type: type)),
      );
    },
    isEditing: false,
  );
});
