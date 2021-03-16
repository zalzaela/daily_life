part of 'list_category_view.dart';

class DetailsCategoryView extends StatelessWidget {
  final String id;

  DetailsCategoryView({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final category = (state as CategoryLoaded)
            .categoryModel
            .firstWhere((category) => category.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Category Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Category',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<CategoryBloc>(context)
                      .add(DeleteCategory(category));
                  Navigator.pop(context, category);
                },
              )
            ],
          ),
          body: category == null
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
                                  tag: '${category.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      category.name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  category.type,
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
            tooltip: 'Edit Category',
            child: Icon(Icons.edit),
            onPressed: category == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FormCategoryView(
                            onSave: (name, type) {
                              BlocProvider.of<CategoryBloc>(context).add(
                                UpdateCategory(
                                  category.copyWith(name: name, type: type),
                                ),
                              );
                            },
                            isEditing: true,
                            categoryModel: category,
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
