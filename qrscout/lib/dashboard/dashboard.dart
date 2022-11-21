import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/bottom_nav.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Scout'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                WidgetsFlutterBinding.ensureInitialized();
                await availableCameras().then((value) =>
                    Navigator.pushNamed(context, '/share', arguments: value));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                padding: const EdgeInsets.all(54),
              ),
              child: const Text('Share Photos'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/recieve'),
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: const EdgeInsets.all(54),
              ),
              child: const Text('Recieve Photos'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
