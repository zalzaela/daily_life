part of 'spending_bloc.dart';

abstract class SpendingState extends Equatable {
  const SpendingState();

  @override
  List<Object> get props => [];
}

class SpendingLoading extends SpendingState {}

class SpendingLoaded extends SpendingState {
  final List<SpendingModel> spendingModel;

  const SpendingLoaded([this.spendingModel = const []]);

  @override
  List<Object> get props => [spendingModel];

  @override
  String toString() => 'SpendingLoaded { spending: $spendingModel }';
}

class SpendingNotLoaded extends SpendingState {}
