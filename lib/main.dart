import 'package:flutter/material.dart';
import 'package:mi_arena/common/widgets/bottombar.dart';
import 'package:mi_arena/features/admin/screens/adminScreen.dart';
import 'package:mi_arena/features/auth/screens/authScreen.dart';
import 'package:mi_arena/features/auth/services/authService.dart';
import 'package:mi_arena/providers/employee_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    AuthService().getEmployeeData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<EmployeeProvider>(context).employee.token == ''
        ? AuthScreen()
        : Provider.of<EmployeeProvider>(context).employee.type == 'admin'
            ? AdminScreen()
            : Bottombar();
  }
}
