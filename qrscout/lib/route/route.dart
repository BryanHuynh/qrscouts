import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:qrscout/home/home.dart';
import 'package:qrscout/login/login.dart';
import 'package:qrscout/dashboard/dashboard.dart';
import 'package:qrscout/settings/settings.dart';
import 'package:qrscout/Activity/Qr_Code.dart';
import 'package:qrscout/Activity/Share.dart';
import 'package:qrscout/Picture/picture.dart';
import 'package:qrscout/collections/collections.dart';
import 'package:qrscout/collections/preview.dart';

import '../Activity/Recieve.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/dashboard': (context) => const DashBoardScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/collections': (context) => const CollectionsScreen(),
  '/share': (context) => ShareScreen(
      cameras: ModalRoute.of(context)!.settings.arguments
          as List<CameraDescription>),
  '/picture': (context) => PictureScreen(
      pictureFile: ModalRoute.of(context)!.settings.arguments as XFile),
  '/qr': (context) =>
      QRCodeScreen(url: ModalRoute.of(context)!.settings.arguments as String),
  '/preview': (context) {
    final Map<String, dynamic> map =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return PreviewScreen(
        imageURLs: map['imageURLs'] as List<String>,
        initialIndex: map['initialIndex'] as int);
  },
  '/recieve': (context) => RecieveScreen(),
};
