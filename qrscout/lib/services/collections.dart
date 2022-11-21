import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:qrscout/services/auth.dart';

class CollectionsService {
  final user = AuthService().user;

  Future<List<String>> getPhotos() async {
    final storage = FirebaseStorage.instance.ref();
    try {
      final ref = storage.child('user/${user!.uid}');
      final list = await ref.listAll();

      List<Photo> photos = [];
      for (var element in list.items) {
        var imageRef = storage.child(element.fullPath);
        final meta = await imageRef.getMetadata();
        await imageRef.getDownloadURL().then((value) => {
              photos.add(Photo(
                  url: value, date: meta.timeCreated!.millisecondsSinceEpoch))
            });
      }
      photos.sort((a, b) => b.date.compareTo(a.date));
      List<String> ret = [];
      for (var element in photos) {
        ret.add(element.url);
      }
      return ret;
    } on FirebaseException catch (e) {
      return [];
    }
  }

  Future<void> deleteCollection() async {
    final storage = FirebaseStorage.instance.ref();
    final ref = storage.child('user/${user!.uid}');
    final list = await ref.listAll();
    for (var element in list.items) {
      var imageRef = storage.child(element.fullPath);
      await imageRef.delete();
    }
  }

  Future<void> deletePhoto(String url) async {
    final storage = FirebaseStorage.instance.ref();
    final ref = storage.child('user/${user!.uid}');
    final list = await ref.listAll();
    for (var element in list.items) {
      var imageRef = storage.child(element.fullPath);
      await imageRef.getDownloadURL().then((value) => {
            if (value == url) {imageRef.delete()}
          });
    }
  }

  // download photo
  Future<void> downloadPhoto(String url) async {
    final storage = FirebaseStorage.instance.ref();
    final ref = storage.child('user/${user!.uid}');
    final list = await ref.listAll();
    for (var element in list.items) {
      var imageRef = storage.child(element.fullPath);
      await imageRef.getDownloadURL().then((value) => {
            if (value == url)
              {
                // imageRef.writeToFile(File('path/to/file'))
              }
          });
    }
  }
}

class Photo {
  final String url;
  final int date;

  Photo({required this.url, required this.date});
}
