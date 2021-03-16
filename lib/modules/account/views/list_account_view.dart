import 'package:daily_life/modules/account/blocs/account_bloc.dart';
import 'package:daily_life/modules/category/blocs/category_bloc.dart';
import 'package:daily_life/modules/category/models/category_models.dart';
import 'package:daily_life/utils/widgets/delete_snackbar.dart';
import 'package:daily_life/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/account/models/account_models.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'details_account_view.dart';
part 'form_account_view.dart';
part 'item_account_view.dart';

class ListViewAccount extends StatelessWidget {
  ListViewAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addEditAccount');
        },
        child: Icon(Icons.add),
        tooltip: 'Add Account',
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return LoadingIndicator();
          } else if (state is AccountLoaded) {
            final accountModel = state.accountModel;
            return Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: accountModel.length,
                itemBuilder: (context, index) {
                  final account = accountModel[index];
                  return ItemAccountView(
                    accountModel: account,
                    onTap: () async {
                      final removedAccount = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return DetailsAccountView(id: account.id);
                        }),
                      );
                      if (removedAccount != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          DeleteSnackBar(
                            text: account.name,
                            onUndo: () => BlocProvider.of<AccountBloc>(context)
                                .add(AddAccount(account)),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
