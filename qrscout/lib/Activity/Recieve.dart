import 'package:flutter/material.dart';
import 'package:qrscout/services/Auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

class RecieveScreen extends StatefulWidget {
  const RecieveScreen({Key? key}) : super(key: key);

  @override
  State<RecieveScreen> createState() => _RecieveScreenState();
}

class _RecieveScreenState extends State<RecieveScreen> {
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  late String url;

  @override
  void initState() {
    super.initState();
    // generate a random password
    final String password = generateRandomString(15);
    url =
        'https://qrscout-web.vercel.app/session/${AuthService().user?.uid}?key=$password';
    AuthService().updateUserRecievingState(state: true, password: password);
    print(url);
  }

  @override
  void dispose() {
    AuthService().updateUserRecievingState(state: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recieve'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Scan this QR code to send data to this device',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            QrImage(
              backgroundColor: Colors.white,
              data: url,
              version: QrVersions.auto,
              size: 200.0,
            ),
            Text(
              url,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
