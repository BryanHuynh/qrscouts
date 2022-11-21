import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qrscout/services/auth.dart';
import 'package:path_provider/path_provider.dart';

Future<String> uploadPicture(XFile pictureFile) async {
  final user = AuthService().user;
  final storage = FirebaseStorage.instance.ref();
  final ref = storage.child('user/${user!.uid}/${pictureFile.name}');
  final file = File(pictureFile.path);
  try {
    await ref.putFile(file);
    final url = await ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    print(e);
    return '';
  }
}
