class Address {
    final String city_from;
    final String created_at;
    final String from_address;
    final String from_person;
    final String from_phone;
    final String id;
    final String state_from;
    final String updated_at;
    final String user_id;

    Address({this.city_from, this.created_at, this.from_address, this.from_person, this.from_phone, this.id, this.state_from, this.updated_at, this.user_id});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            city_from: json['city_from'] != null ? json['city_from'] : json['city_to'],
            created_at: json['created_at'], 
            from_address: json['from_address'] != null ? json['from_address'] : json['to_address'],
            from_person: json['from_person'] != null ? json['from_person'] : json['to_person'],
            from_phone: json['from_phone'] != null ? json['from_phone'] : json['to_phone'],
            id: json['id'], 
            state_from: json['state_from'] != null ? json['state_from'] : json['state_to'],
            updated_at: json['updated_at'], 
            user_id: json['user_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['city_from'] = this.city_from;
        data['created_at'] = this.created_at;
        data['from_address'] = this.from_address;
        data['from_person'] = this.from_person;
        data['from_phone'] = this.from_phone;
        data['id'] = this.id;
        data['state_from'] = this.state_from;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        return data;
    }
}