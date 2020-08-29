class Delivery {
    final String cost;
    final String delivery_no;
    final String delivery_status;
    final FromDetails from_details;
    final String id;
    final String items;
    final String location_from;
    final String location_to;
    final String quantity;
    final String shipping_class;
    final String state_from;
    final String state_to;
    final ToDetails to_details;
    final String weight;

    Delivery({this.cost, this.delivery_no, this.delivery_status, this.from_details, this.id, this.items, this.location_from, this.location_to, this.quantity, this.shipping_class, this.state_from, this.state_to, this.to_details, this.weight});

    factory Delivery.fromJson(Map<String, dynamic> json) {
        return Delivery(
            cost: json['cost'], 
            delivery_no: json['delivery_no'], 
            delivery_status: json['delivery_status'], 
            from_details: json['from_details'] != null ? FromDetails.fromJson(json['from_details']) : null, 
            id: json['id'], 
            items: json['items'], 
            location_from: json['location_from'], 
            location_to: json['location_to'], 
            quantity: json['quantity'], 
            shipping_class: json['shipping_class'], 
            state_from: json['state_from'], 
            state_to: json['state_to'], 
            to_details: json['to_details'] != null ? ToDetails.fromJson(json['to_details']) : null, 
            weight: json['weight'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cost'] = this.cost;
        data['delivery_no'] = this.delivery_no;
        data['delivery_status'] = this.delivery_status;
        data['id'] = this.id;
        data['items'] = this.items;
        data['location_from'] = this.location_from;
        data['location_to'] = this.location_to;
        data['quantity'] = this.quantity;
        data['shipping_class'] = this.shipping_class;
        data['state_from'] = this.state_from;
        data['state_to'] = this.state_to;
        data['weight'] = this.weight;
        if (this.from_details != null) {
            data['from_details'] = this.from_details.toJson();
        }
        if (this.to_details != null) {
            data['to_details'] = this.to_details.toJson();
        }
        return data;
    }
}

class ToDetails {
    final String to_address;
    final String to_person;
    final String to_phone;

    ToDetails({this.to_address, this.to_person, this.to_phone});

    factory ToDetails.fromJson(Map<String, dynamic> json) {
        return ToDetails(
            to_address: json['to_address'],
            to_person: json['to_person'],
            to_phone: json['to_phone'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['to_address'] = this.to_address;
        data['to_person'] = this.to_person;
        data['to_phone'] = this.to_phone;
        return data;
    }
}

class FromDetails {
    final String from_address;
    final String from_person;
    final String from_phone;

    FromDetails({this.from_address, this.from_person, this.from_phone});

    factory FromDetails.fromJson(Map<String, dynamic> json) {
        return FromDetails(
            from_address: json['from_address'],
            from_person: json['from_person'],
            from_phone: json['from_phone'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['from_address'] = this.from_address;
        data['from_person'] = this.from_person;
        data['from_phone'] = this.from_phone;
        return data;
    }
}