class DeliveryAddressRequest {
    final String addressType;
    String cityTo;
    final String toAddress;
    final String toPerson;
    final String toPhone;
    String stateTo;

    DeliveryAddressRequest({this.addressType, this.cityTo, this.toAddress, this.toPerson, this.toPhone, this.stateTo});

    factory DeliveryAddressRequest.fromJson(Map<String, dynamic> json) {
        return DeliveryAddressRequest(
            addressType: json['address_type'], 
            cityTo: json['city_to'],
            toAddress: json['to_address'],
            toPerson: json['to_person'],
            toPhone: json['to_phone'],
            stateTo: json['state_to'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address_type'] = this.addressType;
        data['city_to'] = this.cityTo;
        data['to_address'] = this.toAddress;
        data['to_person'] = this.toPerson;
        data['to_phone'] = this.toPhone;
        data['state_to'] = this.stateTo;
        return data;
    }
}

class PickUpAddressRequest {
    final String addressType;
    String cityFrom;
    final String fromAddress;
    final String fromPerson;
    final String fromPhone;
    String stateFrom;

    PickUpAddressRequest({this.addressType, this.cityFrom, this.fromAddress, this.fromPerson, this.fromPhone, this.stateFrom});

    factory PickUpAddressRequest.fromJson(Map<String, dynamic> json) {
        return PickUpAddressRequest(
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