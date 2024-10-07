part of 'home_bloc.dart';


@immutable
sealed class HomeEvent {}

final class LoadAddressEvent extends HomeEvent{

  final LatLng point;

  LoadAddressEvent({required this.point});

}
final class RemoveLoadedAddresses extends HomeEvent{}
final class SelectAddressEvent extends HomeEvent{

  final AddressModel address;

  SelectAddressEvent({required this.address});

}
final class CalculateValuationEvent extends HomeEvent{

  final double value;

  CalculateValuationEvent({required this.value});
}