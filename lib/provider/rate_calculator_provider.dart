import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/response/area_response.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/state_repository.dart';

class RateCalculatorProvider extends ChangeNotifier{

  StateRepository _stateRepository = locator<StateRepository>();

  ApiResponse<AreaResponse> fromAreaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
  ApiResponse<AreaResponse> toAreaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));

  int fromStateId = 0;
  int toStateId = 0;
  int fromAreaId = 0;
  int toAreaId = 0;

  reset(){
    fromStateId = 0;
    toStateId = 0;
    fromAreaId = 0;
    toAreaId = 0;
  }

  Future<ApiResponse<AreaResponse>> getFromArea(int stateId) async {
    fromStateId = stateId;
    fromAreaResponse = ApiResponse<AreaResponse>.loading('');
    notifyListeners();

    fromAreaResponse = await _stateRepository.getAreaCity(stateId);
    if(fromAreaResponse.status == Status.ERROR){
      getFromArea(stateId);
    }
    notifyListeners();

    return fromAreaResponse;
  }

  Future<ApiResponse<AreaResponse>> getToArea(int stateId) async {
    toStateId = stateId;
    toAreaResponse = ApiResponse<AreaResponse>.loading('');
    notifyListeners();

    toAreaResponse = await _stateRepository.getAreaCity(stateId);
    if(toAreaResponse.status == Status.ERROR){
      getToArea(stateId);
    }
    notifyListeners();

    return toAreaResponse;
  }

  Future<void> calculate() async {

    print(fromStateId);
    print(fromAreaId);
    print(toStateId);
    print(toAreaId);
  }


  setFromAreaId(String id){
    fromAreaId = int.parse(id);
    notifyListeners();
  }

  setToAreaId(String id){
    toAreaId = int.parse(id);
    notifyListeners();
  }

}