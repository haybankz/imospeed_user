class CalculateDeliveryRequest {
    final String cityFrom;
    final String cityTo;
    final List<Item> items;
    final String quantity;
    final String stateFrom;
    final String stateTo;
    final String weight;

    CalculateDeliveryRequest({this.cityFrom, this.cityTo, this.items, this.quantity, this.stateFrom, this.stateTo, this.weight});

    factory CalculateDeliveryRequest.fromJson(Map<String, dynamic> json) {
        return CalculateDeliveryRequest(
            cityFrom: json['city_from'], 
            cityTo: json['city_to'], 
            items: json['items'] != null ? (json['items'] as List).map((i) => Item.fromJson(i)).toList() : null, 
            quantity: json['quantity'], 
            stateFrom: json['state_from'], 
            stateTo: json['state_to'], 
            weight: json['weight'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['city_from'] = this.cityFrom;
        data['city_to'] = this.cityTo;
        data['quantity'] = this.quantity;
        data['state_from'] = this.stateFrom;
        data['state_to'] = this.stateTo;
        data['weight'] = this.weight;
        if (this.items != null) {
            data['items'] = this.items.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Item {
    final String quantity;
    final String title;
    final String weight;

    Item({this.quantity, this.title, this.weight});

    factory Item.fromJson(Map<String, dynamic> json) {
        return Item(
            quantity: json['quantity'],
            title: json['title'],
            weight: json['weight'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['quantity'] = this.quantity;
        data['title'] = this.title;
        data['weight'] = this.weight;
        return data;
    }
}