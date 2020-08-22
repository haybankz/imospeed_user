import 'package:imospeed_user/model/login_user.dart';

class UserData {
  final String accessToken;
  final User user;

  UserData({this.accessToken, this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      accessToken: json['access_token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}