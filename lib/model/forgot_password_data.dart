class Data {
  final String email;
  final String pinSent;

  Data({this.email, this.pinSent});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json['email'],
      pinSent: json['pin-sent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['pin-sent'] = this.pinSent;
    return data;
  }
}