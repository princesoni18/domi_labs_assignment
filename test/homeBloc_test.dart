
import 'package:domi_labs/features/home/bloc/home_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){


  test('given Home bloc when it is initiated then check the default value of _value variable',(){

  
  final homeBloc =HomeBloc();

  final val=homeBloc.value;

  expect(val, 0.2);
  }
  );

  test("given Home bloc when it is initiated then check the default value of the selectedAddress", (

    
  ){

    final homeBloc =HomeBloc();

    final selectedAddressValue=homeBloc.selectedAddress;

    expect(selectedAddressValue, null);
  });

  test("given HomeBloc when LoadAddressEvent is added then it fetches the addresses of the particular Latlng", (){
    final homeBloc=HomeBloc();

     homeBloc.add(LoadAddressEvent(point: const LatLng(27.967533, -82.455235)));

    if(homeBloc.state is AddressLoadedState){
     final addressesListvalue=homeBloc.addresses;
    expect(addressesListvalue.length>0, true);
    }

    
  });
}