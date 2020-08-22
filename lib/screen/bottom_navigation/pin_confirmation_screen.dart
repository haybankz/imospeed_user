import 'package:flutter/material.dart';
import 'package:imospeed_user/model/request/pin_confirmation_request.dart';
import 'package:imospeed_user/model/response/check_pin_response.dart';
import 'package:imospeed_user/model/response/pin_confirmation_response.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/screen/change_password_screen.dart';
import 'package:imospeed_user/screen/login_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PinConfirmationScreen extends StatelessWidget {
  final TextEditingController _pinController = TextEditingController();
  final String email;
  final PinConfirmationType pinConfirmationType;



  PinConfirmationScreen(
      { @required this.email, this.pinConfirmationType = PinConfirmationType.PIN_CONFIRMATION});

  final _formKey = GlobalKey<FormState>();
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
//        resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
              width: screenWidth(context),
              height: screenHeight(context),
            ),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context),
            color: Colors.brown.withOpacity(0.3),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/imospeed_logo.png',
                      height: 80, width: 180),
                  YMargin(10),
                  Text(
                    'Confirm your pin',
                    style: TextStyle(
                        color: Constants.lightPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  YMargin(16),
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        TextInputWidget(
                          controller: _pinController,
                          hintText: 'Enter your Pin',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.length > 0) return null;
                            return 'Enter your pin.';
                          },
                        ),
                        YMargin(20),
                        ButtonWidget(
                          loading: pinConfirmationType == PinConfirmationType.PIN_CONFIRMATION ? (_authProvider.confirmPinResponse.status == Status.LOADING)
                              : (_authProvider.checkPinResponse.status == Status.LOADING),
                          text: 'Confirm pin',
                          onPressed: () async {
//                          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                            FocusScope.of(context).requestFocus(FocusNode());
                            _formKey.currentState.save();
                            if (_formKey.currentState.validate()) {
                              PinConfirmationRequest request = PinConfirmationRequest(email: email, pin: _pinController.text.trim());

                              if(pinConfirmationType == PinConfirmationType.PIN_CONFIRMATION){
                                ApiResponse<PinConfirmationResponse> response = await _authProvider.confirmPin(request);
                                if(response.status == Status.COMPLETED){
                                  Toast.show(response.data.title, context, duration: 2);
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (_)=> LoginScreen()),
                                          (route) => false);
                                }else{
                                  Toast.show(response.message, context, duration: 2);
                                }
                              }else{
                                ApiResponse<CheckPinResponse> response = await _authProvider.checkPin(request);
                                if(response.status == Status.COMPLETED){
                                  Toast.show(response.data.title, context, duration: 2);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => ChangePasswordScreen(email: email, pin: _pinController.text.trim())));
                                }else{
                                  Toast.show(response.message, context, duration: Toast.LENGTH_LONG);
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum PinConfirmationType { PIN_CONFIRMATION, PIN_CHECK }
