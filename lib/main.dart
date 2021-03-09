import 'package:daily_life/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:daily_life/vendor/components/app_bars.dart';
import 'package:daily_life/modules/Credit/views/index.dart';
import 'package:daily_life/modules/Income/views/index.dart';
import 'package:daily_life/modules/Settings/views/index.dart';
import 'package:daily_life/modules/dahboard/views/index.dart';
import 'package:daily_life/modules/spending/views/index.dart';

// void main() => runApp(DailyLife());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DailyLife());
}

final key = new GlobalKey<_MainScreenState>();

class DailyLife extends StatelessWidget {
  DailyLife() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Routes.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daily Life",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/auth',
      onGenerateRoute: Routes.router.generator,
    );
  }
}

class MainScreen extends StatefulWidget {
  final User user;
  final int page;
  MainScreen({
    Key key,
    @required this.user, this.page
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem;
  var _menuName = ["Income", "Spending", "Dashboard", "Credit", ""];

  List<Widget> _menu = [
    Income(),
    Spending(),
    Dashboard(),
    Credit(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    _selectedItem = 2;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar01(
        iconList: [
          FontAwesomeIcons.moneyBillAlt,
          FontAwesomeIcons.cartPlus,
          FontAwesomeIcons.home,
          FontAwesomeIcons.solidCreditCard,
          FontAwesomeIcons.cogs
        ],
        onChange: (val) {
          setState(() {
            _selectedItem = val;
          });
        },
        defaultSelectedIndex: 2,
      ),
      appBar: buildAppBarTrx(),
      body: _menu[_selectedItem], //_menu[_selectedItem],
    );
  }

  Widget buildAppBarTrx() {
    Widget build;
    if (_selectedItem == 0 || _selectedItem == 1 || _selectedItem == 3) {
      build = appBarTrx();
    } else if (_selectedItem == 2 || _selectedItem == 4) {
      build = null;
    } else {
      build = null;
    }

    return build;
  }

  Widget appBarTrx() {
    return AppBar(
      backgroundColor: Colors.grey[100],
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _menuName[_selectedItem],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
              fontFamily: "Roboto-Regular",
            ),
          ),
          Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint("Add Items");
                    switch (_selectedItem) {
                      case 0:
                        {
                          Routes.router.navigateTo(context, "/income/form", transition: TransitionType.material);
                          Routes.router.navigateTo(context, path)
                        }
                        break;
                      case 1:
                        {
                          Routes.router.navigateTo(context, "/spending/form", transition: TransitionType.material);
                        }
                        break;
                      case 3:
                        {
                          Routes.router.navigateTo(context, "/credit/form", transition: TransitionType.material);
                        }
                        break;
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
