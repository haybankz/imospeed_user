import 'package:imospeed_user/model/signup_user.dart';

class SignUpResponse {
    final String code;
    final int status;
    final String title;
    final User user;

    SignUpResponse({this.code, this.status, this.title, this.user});

    factory SignUpResponse.fromJson(Map<String, dynamic> json) {
        return SignUpResponse(
            code: json['code'], 
            status: json['status'], 
            title: json['title'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}

