import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_life/modules/income/models/income_models.dart';
import 'package:daily_life/modules/income/repository/income_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final IncomeRepository _incomeRepository;
  StreamSubscription _incomeSubscription;

  IncomeBloc({@required IncomeRepository incomeRepository})
      : assert(incomeRepository != null),
        _incomeRepository = incomeRepository,
        super(IncomeLoading());

  @override
  Stream<IncomeState> mapEventToState(IncomeEvent event) async* {
    if (event is LoadIncome) {
      yield* _mapLoadIncomeToState();
    } else if (event is AddIncome) {
      yield* _mapAddIncomeToState(event);
    } else if (event is UpdateIncome) {
      yield* _mapUpdateIncomeToState(event);
    } else if (event is DeleteIncome) {
      yield* _mapDeleteIncomeToState(event);
    } else if (event is IncomeUpdated) {
      yield* _mapIncomeUpdateToState(event);
    }
  }

  Stream<IncomeState> _mapLoadIncomeToState() async* {
    _incomeSubscription?.cancel();
    _incomeSubscription = _incomeRepository.income().listen(
          (income) => add(IncomeUpdated(income)),
        );
  }

  Stream<IncomeState> _mapAddIncomeToState(AddIncome event) async* {
    _incomeRepository.addNewIncome(event.incomeModel);
  }

  Stream<IncomeState> _mapUpdateIncomeToState(UpdateIncome event) async* {
    _incomeRepository.updateIncome(event.incomeModel);
  }

  Stream<IncomeState> _mapDeleteIncomeToState(DeleteIncome event) async* {
    _incomeRepository.deleteIncome(event.incomeModel);
  }

  Stream<IncomeState> _mapIncomeUpdateToState(IncomeUpdated event) async* {
    yield IncomeLoaded(event.incomeModel);
  }

  @override
  Future<void> close() {
    _incomeSubscription?.cancel();
    return super.close();
  }
}
