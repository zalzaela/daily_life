import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_life/modules/spending/models/spending_models.dart';
import 'package:daily_life/modules/spending/repository/spending_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'spending_event.dart';
part 'spending_state.dart';

class SpendingBloc extends Bloc<SpendingEvent, SpendingState> {
  final SpendingRepository _spendingRepository;
  StreamSubscription _spendingSubscription;

  SpendingBloc({@required SpendingRepository spendingRepository})
      : assert(spendingRepository != null),
        _spendingRepository = spendingRepository,
        super(SpendingLoading());

  @override
  Stream<SpendingState> mapEventToState(SpendingEvent event) async* {
    if (event is LoadSpending) {
      yield* _mapLoadSpendingToState();
    } else if (event is AddSpending) {
      yield* _mapAddSpendingToState(event);
    } else if (event is UpdateSpending) {
      yield* _mapUpdateSpendingToState(event);
    } else if (event is DeleteSpending) {
      yield* _mapDeleteSpendingToState(event);
    } else if (event is SpendingUpdated) {
      yield* _mapSpendingUpdateToState(event);
    }
  }

  Stream<SpendingState> _mapLoadSpendingToState() async* {
    _spendingSubscription?.cancel();
    _spendingSubscription = _spendingRepository.spending().listen(
          (spending) => add(SpendingUpdated(spending)),
        );
  }

  Stream<SpendingState> _mapAddSpendingToState(AddSpending event) async* {
    _spendingRepository.addNewSpending(event.spendingModel);
  }

  Stream<SpendingState> _mapUpdateSpendingToState(UpdateSpending event) async* {
    _spendingRepository.updateSpending(event.spendingModel);
  }

  Stream<SpendingState> _mapDeleteSpendingToState(DeleteSpending event) async* {
    _spendingRepository.deleteSpending(event.spendingModel);
  }

  Stream<SpendingState> _mapSpendingUpdateToState(SpendingUpdated event) async* {
    yield SpendingLoaded(event.spendingModel);
  }

  @override
  Future<void> close() {
    _spendingSubscription?.cancel();
    return super.close();
  }
}
