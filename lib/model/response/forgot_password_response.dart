import 'package:imospeed_user/model/forgot_password_data.dart';

class ForgotPasswordResponse {
    final Data data;
    final String code;
    final int status;
    final String title;

    ForgotPasswordResponse({this.data, this.code, this.status, this.title});

    factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
        return ForgotPasswordResponse(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
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
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

