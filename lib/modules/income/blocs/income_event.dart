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
  final IncomeModel updatedIncome;

  const UpdateIncome(this.updatedIncome);

  @override
  List<Object> get props => [updatedIncome];

  @override
  String toString() => 'UpdateIncome { updatedIncome: $updatedIncome }';
}

class DeleteIncome extends IncomeEvent {
  final IncomeModel incomeModel;

  const DeleteIncome(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];

  @override
  String toString() => 'DeleteIncome { incomeModel: $incomeModel }';
}

class ClearCompleted extends IncomeEvent {}

class ToggleAll extends IncomeEvent {}

class IncomeUpdated extends IncomeEvent {
  final List<IncomeModel> incomeModel;

  const IncomeUpdated(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];
}
