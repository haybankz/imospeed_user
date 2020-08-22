import 'package:imospeed_user/model/response/address.dart';

class AddressesResponse {
    final List<Address> addresses;
    final String code;
    final int status;
    final String title;

    AddressesResponse({this.addresses, this.code, this.status, this.title});

    factory AddressesResponse.fromJson(Map<String, dynamic> json) {
        return AddressesResponse(
            addresses: json['addresses'] != null ? (json['addresses'] as List).map((i) => Address.fromJson(i)).toList() : null,
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
        if (this.addresses != null) {
            data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
        }
        return data;
    }
}