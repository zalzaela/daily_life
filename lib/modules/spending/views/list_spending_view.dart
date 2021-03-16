import 'package:daily_life/modules/account/blocs/account_bloc.dart';
import 'package:daily_life/modules/account/models/account_models.dart';
import 'package:daily_life/modules/category/blocs/category_bloc.dart';
import 'package:daily_life/modules/category/models/category_models.dart';
import 'package:daily_life/modules/spending/blocs/spending_bloc.dart';
import 'package:daily_life/utils/widgets/delete_snackbar.dart';
import 'package:daily_life/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/spending/models/spending_models.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'details_spending_view.dart';
part 'form_spending_view.dart';
part 'item_spending_view.dart';

class ListViewSpending extends StatelessWidget {
  ListViewSpending({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpendingBloc, SpendingState>(
      builder: (context, state) {
        if (state is SpendingLoading) {
          return LoadingIndicator();
        } else if (state is SpendingLoaded) {
          final spendingModel = state.spendingModel;
          return ListView.builder(
            itemCount: spendingModel.length,
            itemBuilder: (context, index) {
              final spending = spendingModel[index];
              return ItemSpendingView(
                spendingModel: spending,
                onTap: () async {
                  final removedSpending = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: spending.id);
                    }),
                  );
                  if (removedSpending != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteSnackBar(
                        text: spending.category,
                        onUndo: () => BlocProvider.of<SpendingBloc>(context)
                            .add(AddSpending(spending)),
                      ),
                    );
                  }
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
