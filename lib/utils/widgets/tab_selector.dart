import 'package:daily_life/utils/models/tab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabSelector extends StatelessWidget {
  final TabModel activeTab;
  final Function(TabModel) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: TabModel.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(TabModel.values[index]),
      items: TabModel.values.map((tab) {
        return BottomNavigationBarItem(
          icon: FaIcon(builIconTab(tab), color: Colors.grey),
          label: builLabelTab(tab),
        );
      }).toList(),
    );
  }

  String builLabelTab(TabModel tab) {
    switch (tab) {
      case TabModel.income:
        return 'Income';
        break;
      case TabModel.spending:
        return 'Spending';
        break;
      case TabModel.credit:
        return 'Credit';
        break;
      case TabModel.setting:
        return 'Settings';
        break;
      default:
        return 'Dashboard';
    }
  }

  IconData builIconTab(TabModel tab) {
    switch (tab) {
      case TabModel.income:
        return FontAwesomeIcons.moneyBillAlt;
        break;
      case TabModel.spending:
        return FontAwesomeIcons.cartPlus;
        break;
      case TabModel.credit:
        return FontAwesomeIcons.solidCreditCard;
        break;
      case TabModel.setting:
        return FontAwesomeIcons.cogs;
        break;
      default:
        return FontAwesomeIcons.home;
    }
  }
}
