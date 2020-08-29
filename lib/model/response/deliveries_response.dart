import 'package:imospeed_user/model/delivery.dart';

class DeliveriesResponse {
    final String code;
    final List<Delivery> deliveries;
    final int status;
    final String title;

    DeliveriesResponse({this.code, this.deliveries, this.status, this.title});

    factory DeliveriesResponse.fromJson(Map<String, dynamic> json) {
        return DeliveriesResponse(
            code: json['code'], 
            deliveries: json['deliveries'] != null ? (json['deliveries'] as List).map((i) => Delivery.fromJson(i)).toList() : null, 
            status: json['status'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        if (this.deliveries != null) {
            data['deliveries'] = this.deliveries.map((v) => v.toJson()).toList();
        }
        return data;
    }
}