part of 'list_spending_view.dart';

typedef OnSaveCallback = Function(
    String accountId, String accountName, int amount, String category, Timestamp date, String note);

class FormSpendingView extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final SpendingModel spendingModel;

  FormSpendingView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.spendingModel,
  }) : super(key: key);

  @override
  _FormSpendingViewState createState() => _FormSpendingViewState();
}

class _FormSpendingViewState extends State<FormSpendingView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _accountName;
  String _accountId;
  String _accountIdName;
  int _amount;
  String _category;
  String _note;
  bool get isEditing => widget.isEditing;
  DateTime _selectedDate;
  TextEditingController _dateController = TextEditingController();

  String readTimestamp(Timestamp timestamp) {
    var format = DateFormat('dd MMMM yyyy');
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return format.format(date);
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    if (isEditing) {
      _dateController.text = readTimestamp(widget.spendingModel.date);
      _accountIdName = widget.spendingModel.accountId+'-'+widget.spendingModel.account;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    _selectDate(BuildContext context) async {
      DateTime newSelectedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2040),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  surface: Colors.grey[300],
                  onSurface: Colors.grey[800],
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child,
            );
          });

      if (newSelectedDate != null) {
        _selectedDate = newSelectedDate;
        _dateController
          ..text = new DateFormat("dd MMMM yyyy").format(_selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _dateController.text.length,
              affinity: TextAffinity.upstream));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Spending' : 'Add Spending',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                color: Colors.blue[200],
                height: 45,
                child: Center(
                  child: TextField(
                    onTap: () => _selectDate(context),
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: _dateController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration.collapsed(hintText: 'Select Date'),
                    style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                  ),
                ),
              ),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state is AccountLoading) {
                    return LoadingIndicator();
                  } else if (state is AccountLoaded) {
                    final accountSpending = state.accountModel;
                    return DropdownButtonFormField(
                      dropdownColor: Colors.grey,
                      value:_accountIdName,
                      hint: Text('Select Account'),
                      icon: FaIcon(FontAwesomeIcons.sortDown),
                      iconSize: 30,
                      elevation: 16,
                      disabledHint:  isEditing ? Text(widget.spendingModel.account) : Text(''),
                      onChanged: (String newValue) {
                        var parts = newValue.split('-');
                        _accountId = parts[0].trim();
                        _accountName = parts[1].trim();
                      },
                      items: isEditing ? null : accountSpending.map((AccountModel accountModel) {
                        return DropdownMenuItem<String>(
                            value: accountModel.id + '-' + accountModel.name,
                            child: Text(accountModel.name));
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              TextFormField(
                initialValue:
                    isEditing ? widget.spendingModel.amount.toString() : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                readOnly: isEditing ? true : false,
                decoration: InputDecoration(
                  hintText: 'Amount',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter amount' : null;
                },
                onSaved: (value) => _amount = int.parse(value),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return LoadingIndicator();
                  } else if (state is CategoryLoaded) {
                    final categorySpending = state.categoryModel
                        .where((category) => category.type == 'spending');
                    return DropdownButtonFormField(
                      dropdownColor: Colors.grey,
                      value:
                          isEditing ? widget.spendingModel.category : _category,
                      hint: Text('Select Category'),
                      icon: FaIcon(FontAwesomeIcons.sortDown),
                      iconSize: 30,
                      elevation: 16,
                      onChanged: (String newValue) {
                        _category = newValue;
                      },
                      items:
                          categorySpending.map((CategoryModel categoryModel) {
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
              TextFormField(
                initialValue: isEditing ? widget.spendingModel.note : '',
                maxLines: 5,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Spending',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_accountId, _accountName, _amount, _category,
                Timestamp.fromDate(_selectedDate), _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
