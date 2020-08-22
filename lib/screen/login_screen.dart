import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/request/login_request.dart';
import 'package:imospeed_user/model/response/login_response.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/screen/forgot_password.dart';
import 'package:imospeed_user/screen/home_screen.dart';
import 'package:imospeed_user/screen/register_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/auth_repository.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/validator.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/password_input.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatelessWidget {

//  @override
//  _LoginState createState() => _LoginState();
//}
//class _LoginState extends State<LoginScreen>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                  Text('Sign in to your account', style: TextStyle(color: Constants.lightPrimary, fontSize: 18, fontWeight: FontWeight.w700),),
                  YMargin(16),
                  Form(
                    key: _formKey,
                    child: Container(
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
                        YMargin(6),
                        PasswordInput(controller: _passwordController, hintText: 'Password', validator: (value){
                          if(value.isEmpty) return 'Password cannnot be empty';
                          if(value.length <= 8) return 'Password must be more than 7 letters';
                          return null;
                        },
                          showObscure: true,
                          keyboardType: TextInputType.visiblePassword,),
                        YMargin(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> ForgotPasswordScreen()));

                                },
                                child: Text('Forgot password?', style: TextStyle(color: Constants.lightPrimary, fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                        YMargin(20),
                        ButtonWidget(
                          text: 'Login',
                          loading: _authProvider.loginResponse.status == Status.LOADING,
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                          _formKey.currentState.save();
                          if(_formKey.currentState.validate()){

                            LoginRequest request = LoginRequest(email: _emailController.text.trim(), password: _passwordController.text.trim());
                            ApiResponse<LoginResponse> response = await _authProvider.login(request);

                            if(response.status == Status.COMPLETED){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                            }else{
                              Toast.show(response.message, context, duration: 2);
                            }
                          }

                        },
                          enabled: true,),
                        YMargin(10),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(color: Constants.lightPrimary, fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=> RegisterScreen()));
                                      },
                                    style: TextStyle(color: Constants.lightAccent, fontSize: 15)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}