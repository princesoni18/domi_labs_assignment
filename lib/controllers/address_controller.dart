import 'dart:convert';

import 'package:domi_labs/jsonData/adress.dart';
import 'package:domi_labs/models/adress_model.dart';

class AddressController {
  static List<AddressModel> fetchAddresses() {


  
    List<dynamic> data = jsonDecode(addressdata) ;

    return data.map((element) => AddressModel.fromJson(element)).toList();
  }
}
