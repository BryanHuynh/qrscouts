import 'package:flutter/material.dart';
import 'package:qrscout/services/Auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RecieveScreen extends StatefulWidget {
  const RecieveScreen({Key? key}) : super(key: key);

  @override
  State<RecieveScreen> createState() => _RecieveScreenState();
}

class _RecieveScreenState extends State<RecieveScreen> {
  final url = 'http://localhost:3000/session/${AuthService().user?.uid}';

  @override
  void initState() {
    super.initState();
    AuthService().updateUserRecievingState(true);
    print(url);
  }

  @override
  void dispose() {
    AuthService().updateUserRecievingState(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recieve'),
      ),
      body: Center(
        child: QrImage(
          backgroundColor: Colors.white,
          data: url,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
