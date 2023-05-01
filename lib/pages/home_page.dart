import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/pages/login_page.dart';

import '../sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Map<String, dynamic>> _journals = [];

  @override
  void initState() {
    super.initState();
    get_users(); // Loading the diary when the app starts
  }

  void get_users() async {
    setState(() {
      isLoading = true;
    });
    // var data = await SqlDb().readData('SELECT * FROM Test');
    var data = await SqlDb().readData('SELECT * FROM User');
    setState(() {
      _journals = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Text('Đăng xuất')),
            (isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(this._journals.toString()),
          ],
        ),
      ),
    );
  }
}
