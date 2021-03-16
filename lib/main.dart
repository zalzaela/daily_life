import 'package:daily_life/modules/account/blocs/account_bloc.dart';
import 'package:daily_life/modules/account/repository/account_repository.dart';
import 'package:daily_life/modules/auth/bloc/authentication_bloc.dart';
import 'package:daily_life/modules/auth/repository/authenticaiton_repository.dart';
import 'package:daily_life/modules/auth/repository/authentication_firebase_provider.dart';
import 'package:daily_life/modules/auth/repository/google_sign_in_provider.dart';
import 'package:daily_life/modules/category/blocs/category_bloc.dart';
import 'package:daily_life/modules/category/models/category_models.dart';
import 'package:daily_life/modules/category/repository/category_repository.dart';
import 'package:daily_life/modules/income/blocs/income_bloc.dart';
import 'package:daily_life/modules/income/repository/income_repository.dart';
import 'package:daily_life/modules/spending/blocs/spending_bloc.dart';
import 'package:daily_life/modules/spending/repository/spending_repository.dart';
import 'package:daily_life/routes/app_fluro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:daily_life/utils/bloc/observer/app_observer_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(DailyLife());
}

class DailyLife extends StatelessWidget {
  DailyLife() {
    final router = FluroRouter();
    RoutesFluro.configureRoutes(router);
    AppFluro.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
              authenticationRepository: AuthenticationRepository(
                authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                    firebaseAuth: FirebaseAuth.instance),
                googleSignInProvider:
                    GoogleSignInProvider(googleSignIn: GoogleSignIn()),
              ),
            );
          },
        ),
        BlocProvider<SpendingBloc>(
          create: (context) {
            return SpendingBloc(
              spendingRepository: FirebaseSpendingRepository(),
            )..add(LoadSpending());
          },
        ),
        BlocProvider<IncomeBloc>(
          create: (context) {
            return IncomeBloc(
              incomeRepository: FirebaseIncomeRepository(),
            )..add(LoadIncome());
          },
        ),
        BlocProvider<AccountBloc>(
          create: (context) {
            return AccountBloc(
              accountRepository: FirebaseAccountRepository(),
            )..add(LoadAccount());
          },
        ),
        BlocProvider<CategoryBloc>(
          create: (context) {
            return CategoryBloc(
              categoryRepository: FirebaseCategoryRepository(),
            )..add(LoadCategory());
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        title: 'Daily Life',
        initialRoute: '/',
        onGenerateRoute: AppFluro.router.generator,
      ),
    );
  }
}
