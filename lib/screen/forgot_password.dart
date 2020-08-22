import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/model/request/forgot_password_request.dart';
import 'package:imospeed_user/model/response/forgot_password_response.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/screen/bottom_navigation/pin_confirmation_screen.dart';
import 'package:imospeed_user/screen/landing_screen.dart';
import 'package:imospeed_user/screen/login_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/validator.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ForgotPasswordScreen extends StatelessWidget{

  final TextEditingController _emailController = TextEditingController();
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
            child: Image.asset('assets/images/bg.jpeg',
              fit: BoxFit.cover,
              width: screenWidth(context), height: screenHeight(context),),
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
                  Image.asset('assets/images/imospeed_logo.png', height: 80, width: 180),
                  YMargin(10),
                  Text('Reset Password', style: TextStyle(color: Constants.lightPrimary, fontSize: 18, fontWeight: FontWeight.w700),),
                  YMargin(16),
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        TextInputWidget(controller: _emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(isEmail(value)) return null;
                            return 'Enter a valid email';

                          },
                        ),

                        YMargin(20),
                        ButtonWidget(
                          loading: _authProvider.forgotPasswordResponse.status == Status.LOADING,
                          text: 'Reset Password',
                          onPressed: () async {
//                          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                          FocusScope.of(context).requestFocus(FocusNode());

                          _formKey.currentState.save();

                          if(_formKey.currentState.validate()){
                            ForgotPasswordRequest request = ForgotPasswordRequest(email: _emailController.text.trim());
                            ApiResponse<ForgotPasswordResponse> response = await _authProvider.forgotPassword(request);
                            if(response.status == Status.COMPLETED){
                              Toast.show(response.data.title, context, duration: Toast.LENGTH_LONG);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => PinConfirmationScreen(email: _emailController.text.trim(),
                              pinConfirmationType: PinConfirmationType.PIN_CHECK,)));
                            }else{
                              Toast.show(response.message, context, duration: Toast.LENGTH_LONG);
                            }
                          }
                        },),
                        YMargin(10),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Go back to ',
                              style: TextStyle(color: Constants.lightPrimary, fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign in',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginScreen()), (route) => false);
                                      },
                                    style: TextStyle(color: Constants.lightAccent, fontSize: 15)
                                ),
                              ],
                            ),
                          ),
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