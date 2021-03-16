import 'package:daily_life/modules/account/blocs/account_bloc.dart';
import 'package:daily_life/modules/account/models/account_models.dart';
import 'package:daily_life/modules/account/views/list_account_view.dart';
import 'package:daily_life/modules/category/blocs/category_bloc.dart';
import 'package:daily_life/modules/category/models/category_models.dart';
import 'package:daily_life/modules/category/views/list_category_view.dart';
import 'package:daily_life/modules/income/blocs/income_bloc.dart';
import 'package:daily_life/modules/income/models/income_models.dart';
import 'package:daily_life/modules/income/views/list_income_view.dart';
import 'package:daily_life/modules/spending/views/list_spending_view.dart';
import 'package:daily_life/utils/bloc/tab/tab_bloc.dart';
import 'package:daily_life/utils/views/main_view.dart';
import 'package:fluro/fluro.dart';
import 'package:daily_life/modules/auth/bloc/authentication_bloc.dart';
import 'package:daily_life/modules/auth/views/login_view.dart';
import 'package:daily_life/modules/spending/blocs/spending_bloc.dart';
import 'package:daily_life/modules/spending/models/spending_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

part 'routes_Fluro.dart';
part 'route_handlers_fluro.dart';

class AppFluro {
  static FluroRouter router;
}
