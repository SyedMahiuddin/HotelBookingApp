import 'package:flutter/material.dart';
import 'package:hoteljadu/pages/discoverpage.dart';
import 'package:hoteljadu/pages/first_page.dart';
import 'package:hoteljadu/pages/loginpage.dart';

import '../dbhelper/auth.dart';




class LauncherPage extends StatefulWidget {
  static const String routeName='/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthService.user == null) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, FirstPage.routeName);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
