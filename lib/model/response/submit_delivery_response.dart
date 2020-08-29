class SubmitDeliveryResponse {
    final String code;
    final Delivery delivery;
    final int status;
    final String title;

    SubmitDeliveryResponse({this.code, this.delivery, this.status, this.title});

    factory SubmitDeliveryResponse.fromJson(Map<String, dynamic> json) {
        return SubmitDeliveryResponse(
            code: json['code'], 
            delivery: json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null, 
            status: json['status'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        if (this.delivery != null) {
            data['delivery'] = this.delivery.toJson();
        }
        return data;
    }
}

class Delivery {
    final String amount;
    final String created_at;
    final String deliveryNo;
    final String fromAddress;
    final String fromPerson;
    final String fromPhone;
    final String id;
    final String item;
    final String locationFrom;
    final String locationFromId;
    final String locationTo;
    final String locationToId;
    final String quantity;
    final String routeType;
    final String shippingClass;
    final String shippingClassId;
    final String stateFrom;
    final String stateTo;
    final String toAddress;
    final String toPerson;
    final String toPhone;
    final String updated_at;
    final String userId;
    final String weight;

    Delivery({this.amount, this.created_at, this.deliveryNo, this.fromAddress, this.fromPerson, this.fromPhone, this.id, this.item, this.locationFrom, this.locationFromId, this.locationTo, this.locationToId, this.quantity, this.routeType, this.shippingClass, this.shippingClassId, this.stateFrom, this.stateTo, this.toAddress, this.toPerson, this.toPhone, this.updated_at, this.userId, this.weight});

    factory Delivery.fromJson(Map<String, dynamic> json) {
        return Delivery(
            amount: json['amount'],
            created_at: json['created_at'],
            deliveryNo: json['delivery_no'],
            fromAddress: json['from_address'],
            fromPerson: json['from_person'],
            fromPhone: json['from_phone'],
            id: json['id'],
            item: json['item'],
            locationFrom: json['location_from'],
            locationFromId: json['location_from_id'],
            locationTo: json['location_to'],
            locationToId: json['location_to_id'],
            quantity: json['quantity'],
            routeType: json['route_type'],
            shippingClass: json['shipping_class'],
            shippingClassId: json['shipping_class_id'],
            stateFrom: json['state_from'],
            stateTo: json['state_to'],
            toAddress: json['to_address'],
            toPerson: json['to_person'],
            toPhone: json['to_phone'],
            updated_at: json['updated_at'],
            userId: json['user_id'],
            weight: json['weight'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['created_at'] = this.created_at;
        data['delivery_no'] = this.deliveryNo;
        data['from_address'] = this.fromAddress;
        data['from_person'] = this.fromPerson;
        data['from_phone'] = this.fromPhone;
        data['id'] = this.id;
        data['item'] = this.item;
        data['location_from'] = this.locationFrom;
        data['location_from_id'] = this.locationFromId;
        data['location_to'] = this.locationTo;
        data['location_to_id'] = this.locationToId;
        data['quantity'] = this.quantity;
        data['route_type'] = this.routeType;
        data['shipping_class'] = this.shippingClass;
        data['shipping_class_id'] = this.shippingClassId;
        data['state_from'] = this.stateFrom;
        data['state_to'] = this.stateTo;
        data['to_address'] = this.toAddress;
        data['to_person'] = this.toPerson;
        data['to_phone'] = this.toPhone;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.userId;
        data['weight'] = this.weight;
        return data;
    }
}