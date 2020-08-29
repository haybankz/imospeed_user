import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/rate.dart';
import 'package:imospeed_user/model/request/calculate_delivery_request.dart';
import 'package:imospeed_user/model/request/submit_delivery_request.dart';
import 'package:imospeed_user/model/response/area_response.dart';
import 'package:imospeed_user/model/response/delivery_rate_response.dart';
import 'package:imospeed_user/model/response/submit_delivery_response.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/delivery_repository.dart';
import 'package:imospeed_user/service/repository/state_repository.dart';

class NewDeliveryProvider extends ChangeNotifier {

  StateRepository _stateRepository = locator<StateRepository>();
  DeliveryRepository _deliveryRepository = locator<DeliveryRepository>();

  ApiResponse<AreaResponse> pickUpAreaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
  ApiResponse<AreaResponse> deliveryAreaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
  ApiResponse<DeliveryRateResponse> rateResponse = ApiResponse<DeliveryRateResponse>.completed(null);
  ApiResponse<SubmitDeliveryResponse> submitDeliveryResponse = ApiResponse<SubmitDeliveryResponse>.completed(null);

  Address deliveryAddress = Address();
  Address pickUpAddress = Address();
  List<Item> items = [];
  Rate rate = Rate();
  int page = 0;
  int pickUpStateId = 0;
  int pickUpAreaId = 0;
  int deliveryStateId = 0;
  int deliveryAreaId = 0;
  int quantity = 0;
  int weight = 0;
  String pickUpStateName;
  String pickUpAreaName;
 String deliveryStateName;
  String deliveryAreaName;

  reset(){
    page = 0;
    pickUpStateId = 0;
    pickUpAreaId = 0;
    deliveryStateId = 0;
    deliveryAreaId = 0;
    quantity = 0;
    weight = 0;
    deliveryAddress = Address();
    pickUpAddress = Address();
    items = [];
    rate = Rate();
    pickUpAreaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
    deliveryAreaResponse = ApiResponse<AreaResponse>.completed(AreaResponse(areaCities: []));
    notifyListeners();
  }

  setPage(int page){
    this.page = page;
    notifyListeners();
  }

  setPickUpStateId(int id){
    pickUpStateId = id;
    pickUpAddress  = new Address();
    pickUpAddress.state = id.toString();
    notifyListeners();
  }

  setPickAreaId(int id){
    pickUpAreaId = id;
    pickUpAddress.city = id.toString();
    notifyListeners();
  }

  setDeliveryStateId(int id){
    deliveryStateId = id;
    deliveryAddress.id = '';
    deliveryAddress.state = id.toString();

    notifyListeners();
  }

  setDeliveryAreaId(int id){
    deliveryAreaId = id;
    deliveryAddress.city = id.toString();
    notifyListeners();
  }

  setPickUpStateName(String name){
    pickUpStateName = name;
    notifyListeners();
  }

  setPickUpAreaName(String name){
    pickUpAreaName = name;
    notifyListeners();
  }


  setDeliveryStateName(String name){
    deliveryStateName = name;
    notifyListeners();
  }

  setDeliveryAreaName(String name){
    deliveryAreaName = name;
    notifyListeners();
  }


//  setDeliveryAreaId(int id){
//    pickUpAreaId = id;
//    notifyListeners();
//  }

  setPickUpAddress(Address address){
    pickUpAddress = address;
    pickUpStateId = int.parse(address.state);
    pickUpAreaId = int.parse(address.city);
    notifyListeners();
  }

  setDeliveryAddress(Address address){
    deliveryAddress = address;
    deliveryStateId = int.parse(address.state);
    deliveryAreaId = int.parse(address.city);
    notifyListeners();
  }

  addItem(Item item){
    items.add(item);
    notifyListeners();
  }

  removeItem(Item item){
    items.remove(item);
    notifyListeners();
  }

  editItem(Item oldItem, Item newItem){
    items.remove(oldItem);
    items.add(newItem);
    notifyListeners();
  }

  setRate(Rate rate){
    this.rate = rate;
    notifyListeners();
  }

  _calculateWeightAndQuantity(){
    quantity = 0;
    weight = 0;
    for(final item in items){
      quantity += int.parse(item.quantity);
      weight += int.parse(item.weight) * int.parse(item.quantity);

    }

    notifyListeners();
    print(quantity);
    print(weight);
  }


  Future<ApiResponse<AreaResponse>> getPickUpArea(int stateId) async {
//    this.pickUpStateId = stateId;
    pickUpAreaResponse = ApiResponse<AreaResponse>.loading('');
    notifyListeners();

    pickUpAreaResponse = await _stateRepository.getAreaCity(stateId);
    if(pickUpAreaResponse.status == Status.ERROR){
      getPickUpArea(stateId);
    }
    notifyListeners();

    return pickUpAreaResponse;
  }


  Future<ApiResponse<AreaResponse>> getDeliveryArea(int stateId) async {
//    this.pickUpStateId = stateId;
    deliveryAreaResponse = ApiResponse<AreaResponse>.loading('');
    notifyListeners();

    deliveryAreaResponse = await _stateRepository.getAreaCity(stateId);
    if(deliveryAreaResponse.status == Status.ERROR){
      getPickUpArea(stateId);
    }
    notifyListeners();

    return deliveryAreaResponse;
  }


  Future<ApiResponse<DeliveryRateResponse>> calculateRate() async {
    _calculateWeightAndQuantity();
    rateResponse = ApiResponse<DeliveryRateResponse>.loading('');
    notifyListeners();

    CalculateDeliveryRequest request = CalculateDeliveryRequest(quantity: quantity.toString(), weight: weight.toString(),
    stateFrom: pickUpStateId.toString(), cityFrom: pickUpAreaId.toString(), stateTo: deliveryStateId.toString(), cityTo: deliveryAreaId.toString(),
    items: items);

    rateResponse = await _deliveryRepository.calculateDeliveryRate(request);
    notifyListeners();

    return rateResponse;
  }

  Future<ApiResponse<SubmitDeliveryResponse>> submitDelivery(String transactionRef) async {

    submitDeliveryResponse = ApiResponse<SubmitDeliveryResponse>.loading('');
    notifyListeners();

    SubmitDeliveryRequest request = SubmitDeliveryRequest(
      fromPerson: pickUpAddress.person, toPerson: deliveryAddress.person,
      fromPhone: pickUpAddress.phone, toPhone: deliveryAddress.phone,
      fromAddress: pickUpAddress.address, toAddress: deliveryAddress.address,
      amount: rate.amount.toString(), sessionId: rateResponse.data.response.sessionId,
      shippingClassId: rate.shipping_class_id, transactionRef: transactionRef
    );

    submitDeliveryResponse  = await _deliveryRepository.submitDelivery(request);
    if(submitDeliveryResponse.status != Status.COMPLETED){
      submitDelivery(transactionRef);
    }
    notifyListeners();

    return submitDeliveryResponse;

  }


}