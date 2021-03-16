part of 'list_account_view.dart';

typedef OnSaveCallback = Function(String name, int balance, String type);

class FormAccountView extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final AccountModel accountModel;

  FormAccountView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.accountModel,
  }) : super(key: key);

  @override
  _FormAccountViewState createState() => _FormAccountViewState();
}

class _FormAccountViewState extends State<FormAccountView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  int _balance;
  String _type;
  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Account' : 'Add Account',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.accountModel.name : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter name' : null;
                },
                onFieldSubmitted: (value) {
                  print(value);
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                initialValue:
                    isEditing ? widget.accountModel.balance.toString() : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'Balance',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter balance' : null;
                },
                onSaved: (value) => _balance = int.parse(value),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return LoadingIndicator();
                  } else if (state is CategoryLoaded) {
                    final categoryAccount = state.categoryModel
                        .where((category) => category.type == 'account');
                    return DropdownButtonFormField(
                      dropdownColor: Colors.grey,
                      value: isEditing ? widget.accountModel.type : _type,
                      hint: Text('Select Type'),
                      icon: FaIcon(FontAwesomeIcons.sortDown),
                      iconSize: 30,
                      elevation: 16,
                      onChanged: (String newValue) {
                        _type = newValue;
                      },
                      items: categoryAccount.map((CategoryModel categoryModel) {
                        return DropdownMenuItem<String>(
                            value: categoryModel.name,
                            child: Text(categoryModel.name));
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Account',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_name, _balance, _type);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
