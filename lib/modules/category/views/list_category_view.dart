import 'package:daily_life/modules/category/blocs/category_bloc.dart';
import 'package:daily_life/utils/widgets/delete_snackbar.dart';
import 'package:daily_life/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_life/modules/category/models/category_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'details_category_view.dart';
part 'form_category_view.dart';
part 'item_category_view.dart';

class ListViewCategory extends StatelessWidget {
  ListViewCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Category'),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Spending',
                  icon: FaIcon(FontAwesomeIcons.cartPlus),
                ),
                Tab(
                  text: 'Income',
                  icon: FaIcon(FontAwesomeIcons.moneyBillAlt),
                ),
                Tab(
                  text: 'Account',
                  icon: FaIcon(FontAwesomeIcons.wallet),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addEditCategory');
            },
            child: Icon(Icons.add),
            tooltip: 'Add Category',
          ),
          body: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return LoadingIndicator();
              } else if (state is CategoryLoaded) {
                final categorySpending = state.categoryModel
                    .where((category) => category.type == 'spending');
                final categoryIncome = state.categoryModel
                    .where((category) => category.type == 'income');
                final categoryAccount = state.categoryModel
                    .where((category) => category.type == 'account');
                return TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: categorySpending.length,
                      itemBuilder: (context, index) {
                        final category = categorySpending.toList()[index];
                        return ItemCategoryView(
                          categoryIcon: FontAwesomeIcons.cartPlus,
                          categoryModel: category,
                          onTap: () async {
                            final removedCategory =
                                await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return DetailsCategoryView(id: category.id);
                              }),
                            );
                            if (removedCategory != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                DeleteSnackBar(
                                  text: category.name,
                                  onUndo: () =>
                                      BlocProvider.of<CategoryBloc>(context)
                                          .add(AddCategory(category)),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: categoryIncome.length,
                      itemBuilder: (context, index) {
                        final category = categoryIncome.toList()[index];
                        return ItemCategoryView(
                          categoryIcon: FontAwesomeIcons.moneyBillAlt,
                          categoryModel: category,
                          onTap: () async {
                            final removedCategory =
                                await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return DetailsCategoryView(id: category.id);
                              }),
                            );
                            if (removedCategory != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                DeleteSnackBar(
                                  text: category.name,
                                  onUndo: () =>
                                      BlocProvider.of<CategoryBloc>(context)
                                          .add(AddCategory(category)),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: categoryAccount.length,
                      itemBuilder: (context, index) {
                        final category = categoryAccount.toList()[index];
                        return ItemCategoryView(
                          categoryIcon: FontAwesomeIcons.wallet,
                          categoryModel: category,
                          onTap: () async {
                            final removedCategory =
                                await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return DetailsCategoryView(id: category.id);
                              }),
                            );
                            if (removedCategory != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                DeleteSnackBar(
                                  text: category.name,
                                  onUndo: () =>
                                      BlocProvider.of<CategoryBloc>(context)
                                          .add(AddCategory(category)),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
