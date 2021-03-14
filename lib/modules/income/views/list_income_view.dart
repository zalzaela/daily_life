import 'package:daily_life/modules/income/blocs/income_bloc.dart';
import 'package:daily_life/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/income/models/income_models.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'details_income_view.dart';
part 'form_income_view.dart';
part 'item_income_view.dart';

class ListViewIncome extends StatelessWidget {
  ListViewIncome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeBloc, IncomeState>(
      builder: (context, state) {
        if (state is IncomeLoading) {
          return LoadingIndicator();
        } else if (state is IncomeLoaded) {
          final incomeModel = state.incomeModel;
          return ListView.builder(
            itemCount: incomeModel.length,
            itemBuilder: (context, index) {
              final income = incomeModel[index];
              return ItemIncomeView(
                incomeModel: income,
                onTap: () async {
                  final removedIncome = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsIncomeView(id: income.id);
                    }),
                  );
                  if (removedIncome != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteSnackBar(
                        text: income.category,
                        onUndo: () => BlocProvider.of<IncomeBloc>(context)
                            .add(AddIncome(income)),
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
