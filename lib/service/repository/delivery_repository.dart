import 'dart:convert';

import 'package:imospeed_user/model/request/calculate_delivery_request.dart';
import 'package:imospeed_user/model/request/submit_delivery_request.dart';
import 'package:imospeed_user/model/response/deliveries_response.dart';
import 'package:imospeed_user/model/response/delivery_rate_response.dart';
import 'package:imospeed_user/model/response/submit_delivery_response.dart';
import 'package:imospeed_user/service/api_helper.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryRepository{
  ApiBaseHelper _helper = ApiBaseHelper();


  Future<ApiResponse<DeliveryRateResponse>> calculateDeliveryRate(CalculateDeliveryRequest request) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.post('/user/shipping/calculate', request, headers).then((data){
      if(data.statusCode == 200){

        if(json.decode(data.body)['title'] == 'Routes fetched successfully') {
          DeliveryRateResponse rateResponse = DeliveryRateResponse.fromJson(json.decode(data.body));
          return ApiResponse<DeliveryRateResponse>.completed(rateResponse);
        }else{
          return ApiResponse<DeliveryRateResponse>.error(json.decode(data.body)['title']);
        }
      }
      return ApiResponse<DeliveryRateResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<DeliveryRateResponse>.error(e.toString()));

  }

  Future<ApiResponse<SubmitDeliveryResponse>> submitDelivery(SubmitDeliveryRequest request) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.post('/user/shipping/submit', request, headers).then((data){
      if(data.statusCode == 201){
        SubmitDeliveryResponse rateResponse = SubmitDeliveryResponse.fromJson(json.decode(data.body));
        if(rateResponse.title == 'Delivery created successfully') {
          return ApiResponse<SubmitDeliveryResponse>.completed(rateResponse);
        }else{
          return ApiResponse<SubmitDeliveryResponse>.error(rateResponse.title);
        }
      }
      return ApiResponse<SubmitDeliveryResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<SubmitDeliveryResponse>.error(e.toString()));

  }

  Future<ApiResponse<DeliveriesResponse>> getDeliveries() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};


    return _helper.get('/user/shipping/deliveries', headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<DeliveriesResponse>.completed(DeliveriesResponse.fromJson(json.decode(data.body)));
      }
      return ApiResponse<DeliveriesResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<DeliveriesResponse>.error(e.toString()));

  }
}