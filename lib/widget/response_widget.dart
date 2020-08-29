import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';

class Error extends StatelessWidget {
  final String errorMessage;
  Widget child;
  final Function onRetryPressed;

  Error({Key key, this.errorMessage, this.onRetryPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(child == null) child = Constants.smallError;

    return Container(
//      width: screenWidth(context),
//      height: screenHeight(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.lightAccent,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            RaisedButton(
              color: Colors.white,
              child: Text('Retry', style: TextStyle(color: Constants.lightAccent)),
              onPressed: onRetryPressed,
            )
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Constants.lightAccent),
            ),
            YMargin(10),
            Text(
              loadingMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.lightAccent,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Empty extends StatelessWidget {

  Widget child;
  final String message;

  Empty({@required this.message, this.child});

  @override
  Widget build(BuildContext context) {
    if(child == null) child = Constants.smallEmpty;
    return Container(
//      width: screenWidth(context),
//      height: screenHeight(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: child),
            YMargin(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.lightAccent,
                fontSize: 15,
              ),
            ),


          ],
        ),
      ),
    );
  }
}
