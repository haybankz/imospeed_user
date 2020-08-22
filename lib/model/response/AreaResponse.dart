import 'package:imospeed_user/model/area_city.dart';

class AreaResponse {
    final List<AreaCity> areaCities;
    final String message;
    final String status;

    AreaResponse({this.areaCities, this.message, this.status});

    factory AreaResponse.fromJson(Map<String, dynamic> json) {
        return AreaResponse(
            areaCities: json['area_cities'] != null ? (json['area_cities'] as List).map((i) => AreaCity.fromJson(i)).toList() : null, 
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.areaCities != null) {
            data['area_cities'] = this.areaCities.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

