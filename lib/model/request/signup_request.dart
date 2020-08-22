class SignUpRequest {
    final String email;
    final String firstName;
    final String lastName;
    final String password;
    final String passwordConfirmation;
    final String phone;
    final String state;

    SignUpRequest({this.email, this.firstName, this.lastName, this.password, this.passwordConfirmation, this.phone, this.state});

    factory SignUpRequest.fromJson(Map<String, dynamic> json) {
        return SignUpRequest(
            email: json['email'], 
            firstName: json['first_name'], 
            lastName: json['last_name'], 
            password: json['password'], 
            passwordConfirmation: json['password_confirmation'], 
            phone: json['phone'], 
            state: json['state'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['first_name'] = this.firstName;
        data['last_name'] = this.lastName;
        data['password'] = this.password;
        data['password_confirmation'] = this.passwordConfirmation;
        data['phone'] = this.phone;
        data['state'] = this.state;
        return data;
    }
}