import 'package:imospeed_user/model/response/address.dart';

class AddressResponse {
    final Address address;
    final String code;
    final int status;
    final String title;

    AddressResponse({this.address, this.code, this.status, this.title});

    factory AddressResponse.fromJson(Map<String, dynamic> json) {
        return AddressResponse(
            address: json['address'] != null ? Address.fromJson(json['address']) : null, 
            code: json['code'], 
            status: json['status'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        if (this.address != null) {
            data['address'] = this.address.toJson();
        }
        return data;
    }
}