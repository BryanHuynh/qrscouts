import 'package:flutter/material.dart';
import 'package:qrscout/dashboard/dashboard.dart';
import 'package:qrscout/login/login.dart';

import 'package:qrscout/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.hasData) {
            return const DashBoardScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
