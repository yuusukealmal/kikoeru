import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/config/SharedPreferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login() async {
    String account = _accountController.text.trim();
    String password = _passwordController.text.trim();

    if (account.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("請輸入帳號和密碼")),
      );
      return;
    } else {
      bool success =
          await Request.tryFetchToken(account: account, password: password);
      if (success) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("帳號或是密碼有誤")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPreferencesHelper.getString('USER.NAME') != null) {
      _accountController.text = SharedPreferencesHelper.getString('USER.NAME')!;
    }
    if (SharedPreferencesHelper.getString('USER.PASSWORD') != null) {
      _passwordController.text =
          SharedPreferencesHelper.getString('USER.PASSWORD')!;
    }

    return Scaffold(
      appBar: AppBar(title: Text("登入")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: "帳號"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "密碼",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: Text("登入"),
            ),
          ],
        ),
      ),
    );
  }
}
