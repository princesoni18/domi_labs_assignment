part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ActionState extends HomeState{}

final class AddressLoadedState extends HomeState{}
final class ValuationState extends HomeState{}
final class SelectedAddressState extends HomeState{}
final class ValuationOfAddressState extends HomeState{}

final class CompletedState extends ActionState{}
