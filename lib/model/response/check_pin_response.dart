class CheckPinResponse {
    final String code;
    final String correct;
    final int status;
    final String title;

    CheckPinResponse({this.code, this.correct, this.status, this.title});

    factory CheckPinResponse.fromJson(Map<String, dynamic> json) {
        return CheckPinResponse(
            code: json['code'], 
            correct: json['correct'], 
            status: json['status'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['correct'] = this.correct;
        data['status'] = this.status;
        data['title'] = this.title;
        return data;
    }
}