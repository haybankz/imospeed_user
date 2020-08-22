import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiBaseHelper {

  final String baseUrl = "http://imospeedng.ml/v1";

  Future<http.Response> get(String url, dynamic header) async {
    print('call api get request: $url');

    var response;
    try {
      response = await http.get(baseUrl + url, headers: header);

      print('reply api get request: $url : ${response.statusCode}');
//      responseJson = _returnResponse(response);
//      print('code: ${response.statusCode} ${response.body.toString()}');
    } on SocketException {
      print('Error api get request: $url');
      throw Exception('No Internet connection');

//        return null;
    }
    return response;
  }

  Future<http.Response> post(String url, dynamic requestBody,
      dynamic header) async {
    print('call api post request: $url');
    var response;
    try {

        var b = json.encode(requestBody);

        response = await http.post(baseUrl + url, body: b, headers: header);

//      response = _returnResponse(response);
//      print('code: ${response.statusCode} ${response.body.toString()}');
      print('reply api post request: $url : ${response.statusCode}');
    } on SocketException {
      print('Error api post request: $url');

      throw Exception('No Internet connection');
//      return null;
    }
    return response;
  }

  Future<http.Response> patch(String url, dynamic requestBody,
      dynamic header) async {
    print('call api patch request: $url');

    var response;
    try {
      var b = json.encode(requestBody);
      response = await http.patch(baseUrl + url, body: b, headers: header);
//      response = _returnResponse(response);
//      print('code: ${response.statusCode} ${response.body.toString()}');
      print('reply api patch request: $url : ${response.statusCode}');
    } on SocketException {
      print('Error api patch request: $url');

      throw Exception('No Internet connection');
//      return null;
    }
    return response;
  }
}