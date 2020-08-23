import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/request/address_request.dart';
import 'package:imospeed_user/model/response/area_response.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/address_repository.dart';
import 'package:imospeed_user/service/repository/state_repository.dart';

class NewAddressProvider extends ChangeNotifier{
  AddressRepository _addressRepository = locator<AddressRepository>();
  StateRepository _stateRepository = locator<StateRepository>();

  ApiResponse<AreaResponse> areaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
  ApiResponse<String> saveAddressResponse = ApiResponse<String>.completed(null);

  int stateId = 0;
  int areaId = 0;


  reset(){
    stateId = 0;
    areaId = 0;
    areaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
  }


  Future<ApiResponse<AreaResponse>> getArea(int stateId) async {
    this.stateId = stateId;
    areaResponse = ApiResponse<AreaResponse>.loading('');
    notifyListeners();

    areaResponse = await _stateRepository.getAreaCity(stateId);
    if(areaResponse.status == Status.ERROR){
      getArea(stateId);
    }
    notifyListeners();

    return areaResponse;
  }

  setAreaId(String areaId){
    this.areaId = int.parse(areaId);
  }

  Future<ApiResponse<String>> saveAddress(AddressType addressType, dynamic request) async {
    saveAddressResponse = ApiResponse<String>.loading('');
    notifyListeners();

    if(addressType == AddressType.PICKUP) {
      request = request as PickUpAddressRequest;
      request.cityFrom = areaId.toString();
      request.stateFrom = stateId.toString();
    }else{
      request = request as DeliveryAddressRequest;
      request.cityTo = areaId.toString();
      request.stateTo = stateId.toString();
    }

    saveAddressResponse = await _addressRepository.addAddress(request);
    notifyListeners();

    return saveAddressResponse;

  }

}