import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/request/forgot_password_request.dart';
import 'package:imospeed_user/model/request/login_request.dart';
import 'package:imospeed_user/model/response/forgot_password_response.dart';
import 'package:imospeed_user/model/response/login_response.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/provider/delivery_provider.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/provider/rate_calculator_provider.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/screen/dashboard_screen2.dart';
import 'package:imospeed_user/screen/auth/forgot_password.dart';
import 'package:imospeed_user/screen/auth/pin_confirmation_screen.dart';
import 'package:imospeed_user/screen/auth/register_screen.dart';
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
        resizeToAvoidBottomInset: false,

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
                            if(isEmail(value.trim())) return null;
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

                              StateProvider _stateProvider = Provider.of<StateProvider>(context, listen: false);
                              _stateProvider.getStates();

                              RateCalculatorProvider _p = Provider.of<RateCalculatorProvider>(context, listen: false);
                              _p.reset();

                              AddressProvider _addressProvider = Provider.of<AddressProvider>(context, listen: false);
                              _addressProvider.getPickUpAddresses();
                              _addressProvider.getDeliveryAddresses();

                              NewDeliveryProvider _newDeliveryProvider = Provider.of<NewDeliveryProvider>(context, listen: false);
                              _newDeliveryProvider.reset();

                              DeliveryProvider _deliveryProvider = Provider.of<DeliveryProvider>(context, listen: false);
                              _deliveryProvider.getDeliveries();

//                              Navigator.push(context, MaterialPageRoute(builder: (_) => LogisticsHomeScreen()));
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashBoardScreen2()), (route) => false);

                            }else{
                              if(response.message == "Error occurred while making request: Unauthorized"){
                                _showLoading(context);
                                ApiResponse<ForgotPasswordResponse> _res = await _authProvider.forgotPassword(ForgotPasswordRequest(email: _emailController.text.trim()));
                                Navigator.pop(context);
                                if(_res.status == Status.COMPLETED){
                                  Toast.show(_res.data.title, context, duration: Toast.LENGTH_LONG);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => PinConfirmationScreen(email: _emailController.text.trim())));
                                }else{
                                  Toast.show(_res.message, context, duration: Toast.LENGTH_LONG);
                                }
                              }else{
                                Toast.show(response.message, context, duration: Toast.LENGTH_LONG);
                              }

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

  void _showLoading(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: Container(
//            height: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Constants.lightAccent),
                  ),),
                YMargin(10),
                Text('You are yet to activate your account.\nPlease wait while we send an activation pin to your email'),
              ],
            ),
          ),

        );
      },
    );
  }
}