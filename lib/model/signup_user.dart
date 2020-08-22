class User {
  final int active;
  final String businessName;
  final String createdAt;
  final String email;
  final String firstName;
  final String id;
  final String lastName;
  final String phone;
  final int stateId;
  final String updatedAt;
  final int verified;

  User({this.active, this.businessName, this.createdAt, this.email, this.firstName, this.id, this.lastName, this.phone, this.stateId, this.updatedAt, this.verified});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      active: json['active'],
      businessName: json['business_name'],
      createdAt: json['created_at'],
      email: json['email'],
      firstName: json['first_name'],
      id: json['id'],
      lastName: json['last_name'],
      phone: json['phone'],
      stateId: json['state_id'],
      updatedAt: json['updated_at'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['state_id'] = this.stateId;
    data['updated_at'] = this.updatedAt;
    data['verified'] = this.verified;
    data['business_name'] = this.businessName;

    return data;
  }
}