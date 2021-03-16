part of 'list_category_view.dart';

typedef OnSaveCallback = Function(
    String name, String type);

class FormCategoryView extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final CategoryModel categoryModel;

  FormCategoryView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.categoryModel,
  }) : super(key: key);

  @override
  _FormCategoryViewState createState() => _FormCategoryViewState();
}

class _FormCategoryViewState extends State<FormCategoryView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
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
                initialValue: isEditing ? widget.categoryModel.name : '',
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
                initialValue: isEditing ? widget.categoryModel.type : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'Type',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter type' : null;
                },
                onSaved: (value) => _type = value,
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
            widget.onSave(_name, _type);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}