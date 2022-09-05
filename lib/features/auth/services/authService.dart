import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mi_arena/common/widgets/bottombar.dart';
import 'package:mi_arena/constants/error_handling.dart';
import 'package:mi_arena/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../../../constants/constants.dart";
import "package:http/http.dart" as http;

class AuthService {
  void signUp({
    required BuildContext context,
    required String employeeCode,
    required String password,
    required String storeCode,
    required String name,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          "${GlobalVariable.uri}/api/signup",
        ),
        body: jsonEncode({
          'employeeCode': employeeCode,
          'name': name,
          'password': password,
          'storeCode': storeCode,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print("Successs in Auth Service! " + jsonDecode(res.body)['name']);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void signIn({
    required BuildContext context,
    required String employeeCode,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          "${GlobalVariable.uri}/api/signin",
        ),
        body: jsonEncode({
          'employeeCode': employeeCode,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Bottombar()),
            ),
          );
        },
      );
    } catch (e) {
      print(
        "Error in signIn: " + e.toString(),
      );
    }
  }

  void getEmployeeData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) pref.setString('x-auth-token', '');

      http.Response tokenRes = await http.post(
        Uri.parse("${GlobalVariable.uri}/tokenisvalid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      if (json.decode(tokenRes.body) == true) {
        var employee = await http.get(
          Uri.parse("${GlobalVariable.uri}/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        Provider.of<EmployeeProvider>(context, listen: false)
            .setEmpployee(employee.body);
      }
    } catch (e) {
      print("Error in getEmployeeData : " + e.toString());
    }
  }
}
