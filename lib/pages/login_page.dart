import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/pages/sign_up_page.dart';
import './home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang đăng nhập')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tài khoản'),
              SizedBox(height: 12),
              TextFormField(),
              SizedBox(height: 12),
              Text('Mật khẩu'),
              SizedBox(height: 12),
              TextFormField(),
              SizedBox(height: 12),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      child: Text('Đăng nhập'))),
              SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Text('Đăng kí')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
