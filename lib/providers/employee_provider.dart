import 'package:flutter/material.dart';
import 'package:mi_arena/models/employee.dart';

class EmployeeProvider extends ChangeNotifier {
  Employee _employee = Employee(
    id: '',
    name: '',
    employeeCode: '',
    password: '',
    storeCode: '',
    type: '',
    token: '',
  );

  Employee get employee => _employee;

  void setEmpployee(String user) {
    _employee = Employee.fromJson(user);

    notifyListeners();
  }
}
