import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/screen/landing_screen.dart';
import 'package:imospeed_user/screen/login_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/validator.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/text_input.dart';

class ForgotPasswordScreen extends StatelessWidget{

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: <Widget>[
                      TextInputWidget(controller: _emailController,
                        hintText: 'Email', titleText: "",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(isEmail(value)) return null;
                          return 'Enter a valid email';

                        },
                      ),

                      YMargin(20),
                      ButtonWidget(text: 'Reset Password', onPressed: (){
//                          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                      },
                        enabled: true,),
                      YMargin(10),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Reset token sent to email? ',
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
                      ),
                    ],
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