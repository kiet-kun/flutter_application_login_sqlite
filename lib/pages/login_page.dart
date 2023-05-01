import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/pages/sign_up_page.dart';
import './home_page.dart';
import '../sql_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      isLoading = true;
    });
    // await SqlHelper.createTableUser();
    setState(() {
      isLoading = false;
    });
    print('create table user');
  }

  @override
  Widget build(BuildContext context) {
    void _login() async {
      setState(() {
        isLoading = true;
      });
      // await SqlHelper.addUser(
      //     _userNameController.text, _passwordController.text);
      // int response = await sqlDb.insertData(
      //     'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      if (await SqlDb()
              .login(_userNameController.text, _passwordController.text) ==
          true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        const snackBar = SnackBar(
          content: Text('Đăng nhập thất bại'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      setState(() {
        isLoading = false;
      });
    }

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
              TextFormField(
                controller: _userNameController,
              ),
              SizedBox(height: 12),
              Text('Mật khẩu'),
              SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
              ),
              SizedBox(height: 12),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: ElevatedButton(
                          onPressed: () {
                            _login();
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
