import 'dart:convert';

import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/request/address_request.dart';
import 'package:imospeed_user/model/response/address_response.dart';
import 'package:imospeed_user/model/response/addresses_response.dart';
import 'package:imospeed_user/service/api_helper.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse<AddressesResponse>> getPickupAddresses() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.get('/user/shipping/fetch-address', headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<AddressesResponse>.completed(AddressesResponse.fromJson(json.decode(data.body)));
      }
      return ApiResponse<AddressesResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<AddressesResponse>.error(e.toString()));

  }

  Future<ApiResponse<AddressesResponse>> getDeliveryAddresses() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.get('/user/shipping/fetch-address?address_type=destination', headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<AddressesResponse>.completed(AddressesResponse.fromJson(json.decode(data.body)));
      }
      return ApiResponse<AddressesResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<AddressesResponse>.error(e.toString()));

  }

  Future<ApiResponse<AddressResponse>> getAddress( AddressType addressType, String addressId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    String endpoint = '/user/shipping/$addressId/fetch-single-address?address_type=${addressType == AddressType.PICKUP ? Constants.kSource : Constants.kDestination}';

    return _helper.get(endpoint, headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<AddressResponse>.completed(AddressResponse.fromJson(json.decode(data.body)));
      }
      return ApiResponse<AddressResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<AddressResponse>.error(e.toString()));

  }

  Future<ApiResponse<String>> addAddress(dynamic request) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.post('/user/shipping/save-address', request, headers).then((data){
      if(data.statusCode == 201){
        return ApiResponse<String>.completed(json.decode(data.body)['title']);
      }
      return ApiResponse<String>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<String>.error(e.toString()));

  }

  Future<ApiResponse<String>> updateAddress(String addressId, dynamic request) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    return _helper.put('/user/shipping/$addressId/update-address', request, headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<String>.completed(json.decode(data.body)['title']);
      }
      return ApiResponse<String>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<String>.error(e.toString()));

  }

  Future<ApiResponse<String>> deleteAddress(AddressType addressType, String addressId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.kToken);

    dynamic headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    String endpoint = '/user/shipping/$addressId/delete-address?address_type=${addressType == AddressType.PICKUP ? Constants.kSource : Constants.kDestination}';
    return _helper.delete(endpoint, headers).then((data){
      if(data.statusCode == 200){
        return ApiResponse<String>.completed(json.decode(data.body)['title']);
      }
      return ApiResponse<String>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<String>.error(e.toString()));

  }

}