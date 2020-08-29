import 'package:imospeed_user/model/rate.dart';

class DeliveryRateResponse {
    final String code;
    final Response response;
    final int status;
    final String title;

    DeliveryRateResponse({this.code, this.response, this.status, this.title});

    factory DeliveryRateResponse.fromJson(Map<String, dynamic> json) {
        return DeliveryRateResponse(
            code: json['code'], 
            response: (json['response'] != null  && ((json['response']['data'] ?? []) as List).length > 0) ? Response.fromJson(json['response']) : null,
            status: json['status'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        if (this.response != null) {
            data['response'] = this.response.toJson();
        }
        return data;
    }
}

class Response {
    final List<Rate> data;
    final String sessionId;

    Response({this.data, this.sessionId});

    factory Response.fromJson(Map<String, dynamic> json) {
        return Response(
            data: json['data'] != null ? (json['data'] as List).map((i) => Rate.fromJson(i)).toList() : null,
            sessionId: json['session_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['session_id'] = this.sessionId;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}