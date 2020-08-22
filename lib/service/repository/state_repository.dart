import 'dart:convert';

import 'package:imospeed_user/model/response/area_response.dart';
import 'package:imospeed_user/model/response/states_response.dart';
import 'package:imospeed_user/service/api_helper.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateRepository {
  ApiBaseHelper _helper =ApiBaseHelper();

  Future<ApiResponse<StatesResponse>> getStates() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.get('/fetch-states', headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<StatesResponse>.completed(StatesResponse.fromJson(json.decode(data.body)));
      }
      return ApiResponse<StatesResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<StatesResponse>.error(e.toString()));

  }

  Future<ApiResponse<AreaResponse>> getAreaCity(int stateId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.get('/fetch-state-cities/$stateId', headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<AreaResponse>.completed(AreaResponse.fromJson(json.decode(data.body)));
      }
      return ApiResponse<AreaResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<AreaResponse>.error(e.toString()));

  }

}