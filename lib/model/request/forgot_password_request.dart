class ForgotPasswordRequest {
    final String email;

    ForgotPasswordRequest({this.email});

    factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
        return ForgotPasswordRequest(
            email: json['email'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        return data;
    }
}