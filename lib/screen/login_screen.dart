import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset('assets/images/bg.jpeg',
              fit: BoxFit.cover,
              width: screenWidth(context), height: screenHeight(context),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/imospeed_logo.png', height: 160, width: 160),
                  YMargin(50),
                  TextInputWidget(controller: _emailController,
                    hintText: 'Email', titleText: "",
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
                  YMargin(20),
                  ButtonWidget(text: 'Login', onPressed: (){},
                  enabled: true,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}