import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mi_arena/constants/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;

    case 400:
      print(
        "Error in eoor handling widget : " + json.decode(response.body)['msg'],
      );
      break;

    case 500:
      print(
        "Error in eoor handling widget : " + json.decode(response.body)['msg'],
      );
      break;

    default:
      print(
        "Error in eoor handling widget : " + json.decode(response.body),
      );
      break;
  }
}
