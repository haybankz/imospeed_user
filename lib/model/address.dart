class Address {
    final String city;
    final String createdAt;
    final String address;
    final String person;
    final String phone;
    final String id;
    final String state;
    final String updatedAt;
    final String userId;
    final String stateName;
    final String cityName;

    Address({this.city, this.createdAt, this.address, this.person, this.phone, this.id, this.state, this.updatedAt, this.userId, this.stateName, this.cityName});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            city: json['city_from'] != null ? json['city_from'] : json['city_to'],
            createdAt: json['created_at'], 
            address: json['from_address'] != null ? json['from_address'] : json['to_address'],
            person: json['from_person'] != null ? json['from_person'] : json['to_person'],
            phone: json['from_phone'] != null ? json['from_phone'] : json['to_phone'],
            id: json['id'], 
            state: json['state_from'] != null ? json['state_from'] : json['state_to'],
            updatedAt: json['updated_at'],
            userId: json['user_id'], 
            stateName: json['state'] != null ? json['state']['name'] : null,
            cityName: json['city'] != null ? json['city']['name'] : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['city_from'] = this.city;
        data['created_at'] = this.createdAt;
        data['from_address'] = this.address;
        data['from_person'] = this.person;
        data['from_phone'] = this.phone;
        data['id'] = this.id;
        data['state_from'] = this.state;
        data['updated_at'] = this.updatedAt;
        data['user_id'] = this.userId;
//        data['state_name'] = this.stateName;
//        data['city_name'] = this.cityName;
        return data;
    }
}

enum AddressType{PICKUP, DELIVERY}