import 'package:imospeed_user/model/user_data.dart';

class LoginResponse {
    final String code;
    final int status;
    final String title;
    final UserData userData;

    LoginResponse({this.code, this.status, this.title, this.userData});

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
        return LoginResponse(
            code: json['code'], 
            status: json['status'], 
            title: json['title'], 
            userData: json['user_data'] != null ? UserData.fromJson(json['user_data']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        if (this.userData != null) {
            data['user_data'] = this.userData.toJson();
        }
        return data;
    }
}


