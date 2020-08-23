import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: screenWidth(context),
//      height: screenHeight(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 12,
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
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
