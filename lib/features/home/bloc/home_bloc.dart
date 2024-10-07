import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domi_labs/controllers/address_controller.dart';

import 'package:domi_labs/models/adress_model.dart';
import 'package:domi_labs/widgets/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:meta/meta.dart';
import 'package:latlong2/latlong.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

List<AddressModel> _addresses=[];
AddressModel? _selected;


AddressModel? get selectedAddress=>_selected;

double _value=0.2;

double get value=>_value;



List<Marker> _markers=[];

List<Marker> get markers=>_markers;

List<AddressModel> get addresses=>_addresses;
  HomeBloc() : super(HomeInitial()) {
    on<LoadAddressEvent>(loadAddressEvent);

    on<RemoveLoadedAddresses>(removeLoadedAddresses);
    on<SelectAddressEvent>(selectAddressEvent);
    on<CalculateValuationEvent>(calculateValuationEvent);
  }

  FutureOr<void> loadAddressEvent(LoadAddressEvent event, Emitter<HomeState> emit) {

    _addresses=AddressController.fetchAddresses();
    _markers=[
        Marker(
          rotate: false,
            width: 80.0,
            height: 80.0,
            point: event.point,
            child: const CustomMarker()),
      ];
   

    emit(AddressLoadedState());

  }


  FutureOr<void> removeLoadedAddresses(RemoveLoadedAddresses event, Emitter<HomeState> emit) {

     _addresses=[];
    _markers=[];
    _selected=null;
     emit(HomeInitial());
  }

  FutureOr<void> selectAddressEvent(SelectAddressEvent event, Emitter<HomeState> emit) {

    _selected=event.address;

    emit(SelectedAddressState());
  }

  FutureOr<void> calculateValuationEvent(CalculateValuationEvent event, Emitter<HomeState> emit) {

    //logic for the valuation of the house
   _value=event.value;
    
    emit(ValuationOfAddressState());
  }
}
