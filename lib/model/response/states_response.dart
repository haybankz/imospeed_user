import 'package:imospeed_user/model/state.dart';

class StatesResponse {
    final String message;
    final List<State> states;
    final String status;

    StatesResponse({this.message, this.states, this.status});

    factory StatesResponse.fromJson(Map<String, dynamic> json) {
        return StatesResponse(
            message: json['message'], 
            states: json['states'] != null ? (json['states'] as List).map((i) => State.fromJson(i)).toList() : null, 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.states != null) {
            data['states'] = this.states.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

