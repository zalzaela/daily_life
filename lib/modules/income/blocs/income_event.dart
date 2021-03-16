part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

class LoadIncome extends IncomeEvent {}

class AddIncome extends IncomeEvent {
  final IncomeModel incomeModel;

  const AddIncome(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];

  @override
  String toString() => 'AddIncome { incomeModel: $incomeModel }';
}

class UpdateIncome extends IncomeEvent {
  final IncomeModel incomeModel;

  const UpdateIncome(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];

  @override
  String toString() => 'UpdateIncome { incomeModel: $incomeModel }';
}

class DeleteIncome extends IncomeEvent {
  final IncomeModel incomeModel;

  const DeleteIncome(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];

  @override
  String toString() => 'DeleteIncome { incomeModel: $incomeModel }';
}

class IncomeUpdated extends IncomeEvent {
  final List<IncomeModel> incomeModel;

  const IncomeUpdated(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];
}
