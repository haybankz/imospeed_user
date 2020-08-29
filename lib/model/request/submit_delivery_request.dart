class SubmitDeliveryRequest {
    final String amount;
    final String fromAddress;
    final String fromPerson;
    final String fromPhone;
    final String sessionId;
    final String shippingClassId;
    final String toAddress;
    final String toPerson;
    final String toPhone;
    final String transactionRef;

    SubmitDeliveryRequest({this.amount, this.fromAddress, this.fromPerson, this.fromPhone, this.sessionId, this.shippingClassId, this.toAddress, this.toPerson, this.toPhone, this.transactionRef});

    factory SubmitDeliveryRequest.fromJson(Map<String, dynamic> json) {
        return SubmitDeliveryRequest(
            amount: json['amount'], 
            fromAddress: json['from_address'], 
            fromPerson: json['from_person'], 
            fromPhone: json['from_phone'], 
            sessionId: json['session_id'], 
            shippingClassId: json['shipping_class_id'], 
            toAddress: json['to_address'], 
            toPerson: json['to_person'], 
            toPhone: json['to_phone'], 
            transactionRef: json['transaction_ref'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['from_address'] = this.fromAddress;
        data['from_person'] = this.fromPerson;
        data['from_phone'] = this.fromPhone;
        data['session_id'] = this.sessionId;
        data['shipping_class_id'] = this.shippingClassId;
        data['to_address'] = this.toAddress;
        data['to_person'] = this.toPerson;
        data['to_phone'] = this.toPhone;
        data['transaction_ref'] = this.transactionRef;
        return data;
    }
}