import 'package:daily_life/modules/dahboard/views/dashboard_view.dart';
import 'package:daily_life/modules/income/views/list_income_view.dart';
import 'package:daily_life/modules/setting/views/setting_view.dart';
import 'package:daily_life/modules/spending/views/list_spending_view.dart';
import 'package:daily_life/utils/widgets/widgets.dart';
import 'package:daily_life/utils/bloc/tab/tab_bloc.dart';
import 'package:daily_life/utils/models/tab_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabModel>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: buildTitle(activeTab),
            actions: [
              // Filter
            ],
          ),
          body: buildBody(activeTab),
          floatingActionButton: buildFloatingActionButton(context, activeTab),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }

  Widget buildFloatingActionButton(BuildContext context, TabModel activeTab) {
    switch (activeTab) {
      case TabModel.spending:
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addEditSpending');
          },
          child: Icon(Icons.add),
          tooltip: 'Add Spending',
        );
        break;
      case TabModel.income:
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addEditIncome');
          },
          child: Icon(Icons.add),
          tooltip: 'Add Spending',
        );
        break;
      default:
        return null;
    }
  }

  Widget buildBody(TabModel activeTab) {
    switch (activeTab) {
      case TabModel.spending:
        return ListViewSpending();
        break;
      case TabModel.income:
        return ListViewIncome();
        break;
      case TabModel.dashboard:
        return DashboardView();
        break;
      case TabModel.setting:
        return SettingView();
        break;
      default:
        return Container();
    }
  }

  Widget buildTitle(TabModel activeTab) {
    switch (activeTab) {
      case TabModel.spending:
        return Text('Spending');
        break;
      case TabModel.income:
        return Text('Income');
        break;
      case TabModel.dashboard:
        return Text('Dashboard');
        break;
      case TabModel.credit:
        return Text('Credit');
        break;
      case TabModel.setting:
        return Text('Setting');
        break;
      default:
        return Container();
    }
  }
}
