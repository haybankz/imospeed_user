import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/phone_input.dart';
import 'package:imospeed_user/widget/text_input.dart';

class RegisterScreen extends StatefulWidget{

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen>{

  TextEditingController phoneController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        resizeToAvoidBottomInset: false,
//      resizeToAvoidBottomPadding: false,
        //      appBar: AppBar(
//        elevation: 3.0,
//        title: Text('Create an account'),
////        automaticallyImplyLeading: false,
//        centerTitle: false,
//      ),
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
                Image.asset('assets/images/imospeed_logo.png', height: 100, width: 180),
                YMargin(10),
                Text('Create your account', style: TextStyle(color: Constants.lightPrimary,
                    fontSize: 18, fontWeight: FontWeight.w700),),
                YMargin(16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        TextInputWidget(controller: null, hintText: "First Name"),
                        YMargin(10),
                        TextInputWidget(controller: null, hintText: "Last Name"),
                        YMargin(10),
                        TextInputWidget(controller: null, hintText: "Email"),
                        YMargin(10),
                        PhoneInput(hintText: 'Phone Number', titleText: '', controller: phoneController),
                        YMargin(10),
                        TextInputWidget(controller: null, hintText: "Password"),
                        YMargin(10),
                        TextInputWidget(controller: null, hintText: "Confirm Password"),
                        YMargin(10),

                        ButtonWidget(text: 'Create account', onPressed: (){})

                      ],
                    ),
                  ),
                ),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}