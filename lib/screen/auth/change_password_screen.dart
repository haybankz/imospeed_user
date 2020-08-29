import 'package:flutter/material.dart';
import 'package:imospeed_user/model/request/change_password_request.dart';
import 'package:imospeed_user/model/response/change_password_response.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/screen/auth/login_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/password_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ChangePasswordScreen extends StatelessWidget{

  final String email;
  final String pin;

  ChangePasswordScreen({@required this.email, @required this.pin});

  final TextEditingController _passwordController  = TextEditingController();
  final TextEditingController _confirmPasswordController  = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(

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
                  Text('Change Password', style: TextStyle(color: Constants.lightPrimary, fontSize: 18, fontWeight: FontWeight.w700),),
                  YMargin(16),
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        PasswordInput(controller: _passwordController, hintText: "New Password", validator: (value){
                          if(value.length < 8) return 'Password must be more than 7 characters ';
                          if(_confirmPasswordController.text.trim() != value.trim()) return 'Passwords do not match';
                          return null;
                        },),
                        YMargin(6),
                        PasswordInput(controller: _confirmPasswordController, hintText: "Confirm new Password",validator: (value){
                          if(value.length < 8) return 'Password must be more than 7 characters ';
                          if(_passwordController.text.trim() != value.trim()) return 'Passwords do not match';
                          return null;
                        },),

                        YMargin(20),
                        ButtonWidget(
                          loading: _authProvider.changePasswordResponse.status == Status.LOADING,
                          text: 'Set Password',
                          onPressed: () async {
//                          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                          FocusScope.of(context).requestFocus(FocusNode());
                          _formKey.currentState.save();
                          if(_formKey.currentState.validate()){
                            ChangePasswordRequest request = ChangePasswordRequest(email: email, pin: pin, password: _passwordController.text.trim(),
                            passwordConfirmation: _confirmPasswordController.text.trim());

                            ApiResponse<ChangePasswordResponse> response = await _authProvider.changePassword(request);
                            if(response.status == Status.COMPLETED){
                              Toast.show(response.data.title, context, duration: Toast.LENGTH_LONG);
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (_)=> LoginScreen()),
                                      (route) => false);
                            }else{
                              Toast.show(response.message, context, duration: Toast.LENGTH_LONG);
                            }
                          }

                        },),

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