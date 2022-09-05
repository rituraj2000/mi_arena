import 'package:flutter/material.dart';
import 'package:mi_arena/common/widgets/customTextField.dart';
import 'package:mi_arena/common/widgets/custom_button.dart';
import 'package:mi_arena/constants/constants.dart';
import 'package:mi_arena/features/auth/services/authService.dart';

enum Auth { signUp, singIn }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const route = "/auth-screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _managerCodeController = TextEditingController();
  final TextEditingController _storePasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  void signUpUser() {
    authService.signUp(
      context: context,
      name: _nameController.text,
      employeeCode: _employeeCodeController.text,
      password: _passwordController.text,
      storeCode: "MI4",
    );
  }

  void signInUser() {
    authService.signIn(
      context: context,
      employeeCode: _employeeCodeController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text('Xiaomi Point Of Sale'),
            ),
            ListTile(
              title: const Text('Register Cashier'),
              leading: Radio(
                activeColor: GlobalVariable.xiaomiorangeprimary,
                value: Auth.signUp,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signUp)
              Form(
                key: _signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'Name',
                        controller: _nameController,
                      ),
                      CustomTextField(
                        hint: 'Assign an employee code',
                        controller: _employeeCodeController,
                      ),
                      CustomTextField(
                        hint: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        hint: 'Manager Code',
                        controller: _managerCodeController,
                      ),
                      CustomTextField(
                        hint: 'Store Password',
                        controller: _storePasswordController,
                      ),
                      CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            signUpUser();
                          }),
                    ],
                  ),
                ),
              ),
            ListTile(
              title: const Text('Sign In'),
              leading: Radio(
                activeColor: GlobalVariable.xiaomiorangeprimary,
                value: Auth.singIn,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.singIn)
              Form(
                key: _signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'Email',
                        controller: _employeeCodeController,
                      ),
                      CustomTextField(
                        hint: 'Password',
                        controller: _passwordController,
                      ),
                      CustomButton(
                        text: 'Sign In',
                        onTap: () {
                          signInUser();
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _employeeCodeController.dispose();
    _managerCodeController.dispose();
    _storePasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
