part of 'list_category_view.dart';

class ItemCategoryView extends StatelessWidget {
  final GestureTapCallback onTap;
  final CategoryModel categoryModel;
  final IconData categoryIcon;

  ItemCategoryView({
    Key key,
    @required this.onTap,
    @required this.categoryModel,
    @required this.categoryIcon,
  }) : super(key: key);

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
              children: [
                FaIcon(
                  categoryIcon,
                  color: Colors.grey[600],
                  size: 25,
                ),
                SizedBox(width: 10),
                Text(
                  categoryModel.name,
                  style: TextStyle(
                    fontSize: 20,
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
