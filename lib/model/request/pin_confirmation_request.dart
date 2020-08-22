class PinConfirmationRequest {
    final String email;
    final String pin;

    PinConfirmationRequest({this.email, this.pin});

    factory PinConfirmationRequest.fromJson(Map<String, dynamic> json) {
        return PinConfirmationRequest(
            email: json['email'], 
            pin: json['pin'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['pin'] = this.pin;
        return data;
    }
}