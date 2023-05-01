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
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    void _sign_up() async {
      if (_passwordController.text != _confirm_passwordController.text) {
        const snackBar = SnackBar(
          content: Text('Nhập lại mật khẩu sai'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Tài khoản'),
                TextFormField(
                  controller: _userNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập tài khoản";
                    }
                    return null;
                  },
                ),
                Text('Mật khẩu'),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập mật khẩu";
                    }
                    return null;
                  },
                ),
                Text('Xác nhận mật khẩu'),
                TextFormField(
                  controller: _confirm_passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập lại mật khẩu";
                    }
                    return null;
                  },
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _sign_up();
                          }
                        },
                        child: Text('Đăng kí'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
