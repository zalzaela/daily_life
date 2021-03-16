part of 'spending_bloc.dart';

abstract class SpendingEvent extends Equatable {
  const SpendingEvent();

  @override
  List<Object> get props => [];
}

class LoadSpending extends SpendingEvent {}

class AddSpending extends SpendingEvent {
  final SpendingModel spendingModel;

  const AddSpending(this.spendingModel);

  @override
  List<Object> get props => [spendingModel];

  @override
  String toString() => 'AddSpending { spendingModel: $spendingModel }';
}

class UpdateSpending extends SpendingEvent {
  final SpendingModel spendingModel;

  const UpdateSpending(this.spendingModel);

  @override
  List<Object> get props => [SpendingModel];

  @override
  String toString() => 'UpdateSpending { SpendingModel: $SpendingModel }';
}

class DeleteSpending extends SpendingEvent {
  final SpendingModel spendingModel;

  const DeleteSpending(this.spendingModel);

  @override
  List<Object> get props => [spendingModel];

  @override
  String toString() => 'DeleteSpending { spendingModel: $spendingModel }';
}

class SpendingUpdated extends SpendingEvent {
  final List<SpendingModel> spendingModel;

  const SpendingUpdated(this.spendingModel);

  @override
  List<Object> get props => [spendingModel];
}
