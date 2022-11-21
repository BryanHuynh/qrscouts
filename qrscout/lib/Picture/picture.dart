import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qrscout/services/upload_picture.dart';

class PictureScreen extends StatelessWidget {
  final XFile pictureFile;
  const PictureScreen({Key? key, required this.pictureFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Image.file(File(pictureFile.path)),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () => {
              uploadPicture(pictureFile).then((url) => {
                    print(url),
                    Navigator.pushNamed(context, '/qr', arguments: url)
                  })
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ])
      ],
    ));
  }
}
