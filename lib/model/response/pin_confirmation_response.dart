class PinConfirmationResponse {
    final String activated;
    final String code;
    final int status;
    final String title;

    PinConfirmationResponse({this.activated, this.code, this.status, this.title});

    factory PinConfirmationResponse.fromJson(Map<String, dynamic> json) {
        return PinConfirmationResponse(
            activated: json['activated'], 
            code: json['code'], 
            status: json['status'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['activated'] = this.activated;
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        return data;
    }
}