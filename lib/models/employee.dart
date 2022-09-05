import 'dart:convert';

class Employee {
  final String id;
  final String name;
  final String employeeCode;
  final String password;
  final String storeCode;
  final String type;
  final String token;

  Employee({
    required this.id,
    required this.name,
    required this.employeeCode,
    required this.password,
    required this.storeCode,
    required this.type,
    required this.token,
  });

  //KIM : json.decode(String s) gives Map<String, dynamic>

  //API to Frontend

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['_id'],
      name: map['name'],
      employeeCode: map['employeeCode'],
      password: map['password'],
      storeCode: map['storeCode'],
      type: map['type'],
      token: map['token'],
    );
  }

  factory Employee.fromJson(String source) {
    return Employee.fromMap(json.decode(source));
  }

  //Frontend to API

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employeecode': employeeCode,
      'password': password,
      'storeid': storeCode,
      'type': type,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
}
