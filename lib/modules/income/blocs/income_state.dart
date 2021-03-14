part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object> get props => [];
}

class IncomeLoading extends IncomeState {}

class IncomeLoaded extends IncomeState {
  final List<IncomeModel> incomeModel;

  const IncomeLoaded([this.incomeModel = const []]);

  @override
  List<Object> get props => [incomeModel];

  @override
  String toString() => 'IncomeLoaded { income: $incomeModel }';
}

class IncomeNotLoaded extends IncomeState {}
