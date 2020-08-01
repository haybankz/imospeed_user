import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/screen/landing_screen.dart';
import 'package:imospeed_user/screen/register_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/validator.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/password_input.dart';
import 'package:imospeed_user/widget/text_input.dart';

class LoginScreen extends StatelessWidget{

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
//      resizeToAvoidBottomInset: true,
      child: Scaffold(
//        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
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
                      Image.asset('assets/images/imospeed_logo.png', height: 100, width: 180),
                      YMargin(10),
                      Text('Sign in to your account', style: TextStyle(color: Constants.lightPrimary, fontSize: 18, fontWeight: FontWeight.w700),),
                      YMargin(16),
                      TextInputWidget(controller: _emailController,
                        hintText: 'Email', titleText: "",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(isEmail(value)) return null;
                          return 'Enter a valid email';

                        },
                      ),
                      YMargin(10),
                      PasswordInput(controller: _passwordController, hintText: 'Password', validator: (value){
                        if(value.isEmpty) return 'Password cannnot be empty';
                        if(value.length <= 8) return 'Password must be more than 7 letters';
                        return null;
                      },),
                      YMargin(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: (){

                              },
                              child: Text('Forgot password?', style: TextStyle(color: Constants.lightPrimary, fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                      YMargin(20),
                      ButtonWidget(text: 'Login', onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                      },
                      enabled: true,),
                      YMargin(14),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(color: Constants.lightPrimary, fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> LandingScreen()));
                                },
                              style: TextStyle(color: Constants.lightAccent, fontSize: 15)
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
        ),
      ),
    );
  }
}