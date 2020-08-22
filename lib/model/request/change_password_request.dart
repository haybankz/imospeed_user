class ChangePasswordRequest {
    final String email;
    final String password;
    final String passwordConfirmation;
    final String pin;

    ChangePasswordRequest({this.email, this.password, this.passwordConfirmation, this.pin});

    factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
        return ChangePasswordRequest(
            email: json['email'], 
            password: json['password'], 
            passwordConfirmation: json['password_confirmation'], 
            pin: json['pin'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['password'] = this.password;
        data['password_confirmation'] = this.passwordConfirmation;
        data['pin'] = this.pin;
        return data;
    }
}