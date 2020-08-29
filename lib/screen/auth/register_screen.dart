import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/model/request/signup_request.dart';
import 'package:imospeed_user/model/response/sign_up_response.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/screen/auth/pin_confirmation_screen.dart';
import 'package:imospeed_user/screen/auth/login_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/validator.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/password_input.dart';
import 'package:imospeed_user/widget/phone_input.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget{

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen>{

  TextEditingController _firstNameController  = TextEditingController();
  TextEditingController _lastNameController  = TextEditingController();
  TextEditingController _phoneController  = TextEditingController();
  TextEditingController _emailController  = TextEditingController();
  TextEditingController _passwordController  = TextEditingController();
  TextEditingController _confirmPasswordController  = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
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
          Padding(padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              YMargin(20),
              Image.asset('assets/images/imospeed_logo.png', height: 80, width: 180),
              YMargin(10),
              Text('Create your account', style: TextStyle(color: Constants.lightPrimary,
                  fontSize: 18, fontWeight: FontWeight.w700),),
              YMargin(16),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        TextInputWidget(controller: _firstNameController, hintText: "First Name", validator: (value){
                          if(value.length < 2) return 'Enter a valid name';
                          return null;
                        },),
                        YMargin(6),
                        TextInputWidget(controller: _lastNameController, hintText: "Last Name", validator: (value){
                          if(value.length < 2) return 'Enter a valid name';
                          return null;
                        },),
                        YMargin(6),
                        TextInputWidget(controller: _emailController, hintText: "Email", iconData: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress, validator: (value){
                            if(isEmail(value)) return null;
                            return 'Enter a valid email address';
                          },),
                        YMargin(6),
//                        PhoneInput(hintText: 'Phone Number', controller: _phoneController, validator: (value){
//                          if(value.length < 11) return 'Enter a phone number';
//                          return null;
//                        },),
                        TextInputWidget(controller: _phoneController, hintText: '07089000000', iconData: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value){
                              if(value.length < 11) return 'Enter a phone number';
                              return null;
                            }),
                        YMargin(6),
                        PasswordInput(controller: _passwordController, hintText: "Password", validator: (value){
                          if(value.length < 8) return 'Password must be more than 7 characters ';
                          if(_confirmPasswordController.text.trim() != value.trim()) return 'Passwords do not match';
                          return null;
                        },),
                        YMargin(6),
                        PasswordInput(controller: _confirmPasswordController, hintText: "Confirm Password",validator: (value){
                          if(value.length < 8) return 'Password must be more than 7 characters ';
                          if(_passwordController.text.trim() != value.trim()) return 'Passwords do not match';
                          return null;
                        },),
                        YMargin(20),
                        ButtonWidget(
                          loading: _authProvider.signUpResponse.status == Status.LOADING,
                            text: 'Create account',
                            onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _formKey.currentState.save();

                          if(_formKey.currentState.validate()){
                            SignUpRequest request = SignUpRequest(email: _emailController.text.trim(),
                            firstName: _firstNameController.text.trim(), lastName: _lastNameController.text.trim(),
                            password: _passwordController.text.trim(), passwordConfirmation: _confirmPasswordController.text.trim(),
                            phone: _phoneController.text.trim());

                            ApiResponse<SignUpResponse> response = await _authProvider.signUp(request);
                            if(response.status == Status.COMPLETED){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_)=> PinConfirmationScreen(email: _emailController.text.trim(),
                                    pinConfirmationType: PinConfirmationType.PIN_CONFIRMATION,)));
                            }else{
                              Toast.show(response.message, context, duration: 2);
                            }
                          }
                        }),
                        YMargin(10),
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Constants.lightPrimary, fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign in',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
                                    },
                                  style: TextStyle(color: Constants.lightAccent, fontSize: 15)
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),),
        ],
      ),
    );
  }
}