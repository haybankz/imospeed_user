import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/response/area_response.dart';
import 'package:imospeed_user/model/response/states_response.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/state_repository.dart';

class StateProvider extends ChangeNotifier{
  StateRepository _stateRepository = locator<StateRepository>();

  ApiResponse<StatesResponse> stateResponse = ApiResponse<StatesResponse>.completed(null);
  ApiResponse<AreaResponse> areaResponse = ApiResponse<AreaResponse>.completed(null);

  Future<ApiResponse<StatesResponse>> getStates() async {
    stateResponse = ApiResponse<StatesResponse>.loading('');
    notifyListeners();

    stateResponse = await _stateRepository.getStates();
    if(stateResponse.status == Status.ERROR){
      getStates();
    }
    notifyListeners();

    return stateResponse;
  }


  Future<ApiResponse<AreaResponse>> getArea(int stateId) async {
    areaResponse = ApiResponse<AreaResponse>.loading('');
    notifyListeners();

    areaResponse = await _stateRepository.getAreaCity(stateId);
    if(stateResponse.status == Status.ERROR){
      getArea(stateId);
    }
    notifyListeners();

    return areaResponse;
  }


}