class ChangePasswordResponse {
    final String code;
    final int status;
    final String title;
    final String updated;

    ChangePasswordResponse({this.code, this.status, this.title, this.updated});

    factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
        return ChangePasswordResponse(
            code: json['code'], 
            status: json['status'], 
            title: json['title'], 
            updated: json['updated'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['status'] = this.status;
        data['title'] = this.title;
        data['updated'] = this.updated;
        return data;
    }
}