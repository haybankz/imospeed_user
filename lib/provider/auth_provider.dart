import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
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
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthRepository _authRepository = locator<AuthRepository>();

  ApiResponse<LoginResponse> loginResponse =
      ApiResponse<LoginResponse>.completed(null);
  ApiResponse<SignUpResponse> signUpResponse =
      ApiResponse<SignUpResponse>.completed(null);
  ApiResponse<ChangePasswordResponse> changePasswordResponse =
      ApiResponse<ChangePasswordResponse>.completed(null);
  ApiResponse<CheckPinResponse> checkPinResponse =
      ApiResponse<CheckPinResponse>.completed(null);
  ApiResponse<PinConfirmationResponse> confirmPinResponse =
      ApiResponse<PinConfirmationResponse>.completed(null);
  ApiResponse<ForgotPasswordResponse> forgotPasswordResponse =
      ApiResponse<ForgotPasswordResponse>.completed(null);

  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    loginResponse = ApiResponse<LoginResponse>.loading('');
    notifyListeners();

    loginResponse = await _authRepository.login(request);
    notifyListeners();

    return loginResponse;
  }

  Future<ApiResponse<SignUpResponse>> signUp(SignUpRequest request) async {
    signUpResponse = ApiResponse<SignUpResponse>.loading('');
    notifyListeners();

    signUpResponse = await _authRepository.signUp(request);
    notifyListeners();

    return signUpResponse;
  }

  Future<ApiResponse<PinConfirmationResponse>> confirmPin(
      PinConfirmationRequest request) async {
    confirmPinResponse = ApiResponse<PinConfirmationResponse>.loading('');
    notifyListeners();

    confirmPinResponse = await _authRepository.confirmPin(request);
    notifyListeners();

    return confirmPinResponse;
  }

  Future<ApiResponse<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest request) async {
    forgotPasswordResponse = ApiResponse<ForgotPasswordResponse>.loading('');
    notifyListeners();

    forgotPasswordResponse = await _authRepository.forgotPassword(request);
    notifyListeners();

    return forgotPasswordResponse;
  }

  Future<ApiResponse<CheckPinResponse>> checkPin(
      PinConfirmationRequest request) async {
    checkPinResponse = ApiResponse<CheckPinResponse>.loading('');
    notifyListeners();

    checkPinResponse = await _authRepository.checkPin(request);
    notifyListeners();

    return checkPinResponse;
  }


  Future<ApiResponse<ChangePasswordResponse>> changePassword(
      ChangePasswordRequest request) async {
    changePasswordResponse = ApiResponse<ChangePasswordResponse>.loading('');
    notifyListeners();

    changePasswordResponse = await _authRepository.changePassword(request);
    notifyListeners();

    return changePasswordResponse;
  }
}
