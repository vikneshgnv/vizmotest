import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:vizmotest/repository/api/ApiException.dart';


class ApiClient{

//base path for the api
  static final String basePath = 'https://620dfdda20ac3a4eedcf5a52.mockapi.io/api';

  Future<Response> invokeAPI(String path, String method, Object? body
      ) async {
    Map<String, String> headerParams = {

    };
    Response response;

    String url = basePath + path;

    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    switch (method) {
      case "POST":
        response = await post(Uri.parse(url), headers: {'content-Type': 'application/json',}, body: body);
        break;
      case "PUT":
        response = await put(Uri.parse(url), headers: {'content-Type': 'application/json',}, body: body);
        break;
      case "DELETE":
        response = await delete(Uri.parse(url), headers: nullableHeaderParams);
        break;
      case "POST_":
        response = await post(Uri.parse(url), headers:  {'content-Type': 'application/x-www-form-urlencoded','Accept':'application/json'},body: body,);
        break;
      case "GET_":
        response = await post(Uri.parse(url), headers:  {'content-Type': 'application/x-www-form-urlencoded','Accept':'application/json'},body: body,);
        break;
      default:
        response = await get(Uri.parse(url), headers: {'Accept': 'application/json','Content-Type': 'application/json'});
    }

    print('status of $path =>' + (response.statusCode).toString());
    print(response.body);
    if (response.statusCode >= 400) {
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);
      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }

}