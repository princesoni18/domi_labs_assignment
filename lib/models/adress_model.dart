class AddressModel{





  final String street;
  final String landmark;
  final String city;

  AddressModel({required this.street, required this.landmark, required this.city});


factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      landmark: json['landmark'],
      city: json['city'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'landmark': landmark,
      'city': city,
    };
  }



}