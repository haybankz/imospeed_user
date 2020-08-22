import 'dart:convert';

import 'package:imospeed_user/model/request/change_password_request.dart';
import 'package:imospeed_user/model/request/forgot_password_request.dart';
import 'package:imospeed_user/model/request/login_request.dart';
import 'package:imospeed_user/model/request/pin_confirmation_request.dart';
import 'package:imospeed_user/model/request/signup_request.dart';
import 'package:imospeed_user/model/response/change_password_response.dart';
import 'package:imospeed_user/model/response/check_pin_response.dart';
import 'package:imospeed_user/model/response/forgot_password_response.dart';
import 'package:imospeed_user/model/response/login_response.dart';
import 'package:imospeed_user/model/response/pin_confirmation_response.dart';
import 'package:imospeed_user/model/response/sign_up_response.dart';
import 'package:imospeed_user/service/api_helper.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository{
  ApiBaseHelper _helper = ApiBaseHelper();

  
  Future<ApiResponse<SignUpResponse>> signUp(SignUpRequest request) async {
    dynamic _headers = {'Content-Type': 'application/json'};
    return _helper.post('/auth/signup', request, _headers).then((data) {
      if(data.statusCode == 201){
        return ApiResponse<SignUpResponse>.completed(SignUpResponse.fromJson(json.decode(data.body)));
      }else if(data.statusCode == 400){
        return ApiResponse<SignUpResponse>.error(ImoUtil.parseError(json.decode(data.body)['title']));
      }

      return ApiResponse<SignUpResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<SignUpResponse>.error(e.toString()));
  }


  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    dynamic _headers = {'Content-Type' : 'application/json'};
    return _helper.post('/auth/login', request, _headers).then((data) async{
      if(data.statusCode == 201){

        LoginResponse response = LoginResponse.fromJson(json.decode(data.body));

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(Constants.kToken, response.userData.accessToken );
        preferences.setString(Constants.kName, response.userData.user.name);

        return ApiResponse<LoginResponse>.completed(response);

      }else if(data.statusCode == 400){

        return ApiResponse<LoginResponse>.error('User email or password incorrect');
      }

      return ApiResponse<LoginResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<LoginResponse>.error(e.toString()));
  }

  Future<ApiResponse<PinConfirmationResponse>> confirmPin(PinConfirmationRequest request) async {
    dynamic _headers = {'Content-Type': 'application/json'};
    return _helper.post('/auth/activate', request, _headers).then((data) {
      if(data.statusCode == 201){
        return ApiResponse<PinConfirmationResponse>.completed(PinConfirmationResponse.fromJson(json.decode(data.body)));
      }else if(data.statusCode == 400){
        return ApiResponse<PinConfirmationResponse>.error(json.decode(data.body)['title']);
      }

      return ApiResponse<PinConfirmationResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<PinConfirmationResponse>.error(e.toString()));
  }

  Future<ApiResponse<ForgotPasswordResponse>> forgotPassword(ForgotPasswordRequest request) async {
    dynamic _headers = {'Content-Type': 'application/json'};
    return _helper.post('/auth/forgot-password', request, _headers).then((data) {
      if(data.statusCode == 201){
        return ApiResponse<ForgotPasswordResponse>.completed(ForgotPasswordResponse.fromJson(json.decode(data.body)));
      }else if(data.statusCode == 400){
        return ApiResponse<ForgotPasswordResponse>.error('The e-mail address is not associated with any user');
      }

      return ApiResponse<ForgotPasswordResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<ForgotPasswordResponse>.error(e.toString()));
  }

  Future<ApiResponse<CheckPinResponse>> checkPin(PinConfirmationRequest request) async {
    dynamic _headers = {'Content-Type': 'application/json'};
    return _helper.post('/auth/check-pin', request, _headers).then((data) {
      if(data.statusCode == 201){
        return ApiResponse<CheckPinResponse>.completed(CheckPinResponse.fromJson(json.decode(data.body)));
      }else if(data.statusCode == 400){
        return ApiResponse<CheckPinResponse>.error('Incorrect pin. Please confirm your pin');
      }

      return ApiResponse<CheckPinResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<CheckPinResponse>.error(e.toString()));
  }

  Future<ApiResponse<ChangePasswordResponse>> changePassword(ChangePasswordRequest request) async {
    dynamic _headers = {'Content-Type': 'application/json'};
    return _helper.post('/auth/change-password', request, _headers).then((data) {
      if(data.statusCode == 201){
        return ApiResponse<ChangePasswordResponse>.completed(ChangePasswordResponse.fromJson(json.decode(data.body)));
      }else if(data.statusCode == 400){
        return ApiResponse<ChangePasswordResponse>.error('Password change failed');
      }

      return ApiResponse<ChangePasswordResponse>.error('Error occurred while making request: ${data.reasonPhrase}');

    }).catchError((e) => ApiResponse<ChangePasswordResponse>.error(e.toString()));
  }
}