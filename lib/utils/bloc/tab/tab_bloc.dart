import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_life/utils/models/tab_model.dart';
import 'package:equatable/equatable.dart';

part 'tab_event.dart';

class TabBloc extends Bloc<TabEvent, TabModel> {
  TabBloc() : super(TabModel.dashboard);

  @override
  Stream<TabModel> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
