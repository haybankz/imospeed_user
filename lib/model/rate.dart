class Rate {
    final int amount;
    final String from;
    final String shipping_class;
    final String shipping_class_id;
    final String to;

    Rate({this.amount, this.from, this.shipping_class, this.shipping_class_id, this.to});

    factory Rate.fromJson(Map<String, dynamic> json) {
        return Rate(
            amount: json['amount'], 
            from: json['from'], 
            shipping_class: json['shipping_class'], 
            shipping_class_id: json['shipping_class_id'], 
            to: json['to'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['from'] = this.from;
        data['shipping_class'] = this.shipping_class;
        data['shipping_class_id'] = this.shipping_class_id;
        data['to'] = this.to;
        return data;
    }
}