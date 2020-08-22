class AddressRequest {
    final String addressType;
    final String cityFrom;
    final String fromAddress;
    final String fromPerson;
    final String fromPhone;
    final String stateFrom;

    AddressRequest({this.addressType, this.cityFrom, this.fromAddress, this.fromPerson, this.fromPhone, this.stateFrom});

    factory AddressRequest.fromJson(Map<String, dynamic> json) {
        return AddressRequest(
            addressType: json['address_type'], 
            cityFrom: json['city_from'], 
            fromAddress: json['from_address'],
            fromPerson: json['from_person'],
            fromPhone: json['from_phone'], 
            stateFrom: json['state_from'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address_type'] = this.addressType;
        data['city_from'] = this.cityFrom;
        data['from_address'] = this.fromAddress;
        data['from_person'] = this.fromPerson;
        data['from_phone'] = this.fromPhone;
        data['state_from'] = this.stateFrom;
        return data;
    }
}