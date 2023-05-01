import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_login/pages/login_page.dart';

import '../sql_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirm_passwordController =
      TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    void _sign_up() async {
      setState(() {
        isLoading = true;
      });
      var user_name = _userNameController.text;
      var password = _passwordController.text;
      if (await SqlDb().userExists(user_name) == true) {
        const snackBar = SnackBar(
          content: Text('Tài khoản đã tồn tại'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        await SqlDb().insertData(
            'INSERT INTO User(user_name, password) VALUES("${user_name}", "${password}")');
        const snackBar = SnackBar(
          content: Text('Đăng kí tài khoản thành công'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Trang đăng kí')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Tài khoản'),
            TextFormField(
              controller: _userNameController,
            ),
            Text('Mật khẩu'),
            TextFormField(
              controller: _passwordController,
            ),
            Text('Xác nhận mật khẩu'),
            TextFormField(
              controller: _confirm_passwordController,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      _sign_up();
                    },
                    child: Text('Đăng kí'))
          ],
        ),
      ),
    );
  }
}
