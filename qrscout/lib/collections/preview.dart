import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PreviewScreen extends StatefulWidget {
  final List<String> imageURLs;
  final int initialIndex;
  const PreviewScreen(
      {Key? key, required this.imageURLs, required this.initialIndex})
      : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool tapped = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tapped = false;
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          (tapped ? null : CustomAppBar(url: widget.imageURLs[currentIndex])),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.imageURLs[index]),
            initialScale: PhotoViewComputedScale.contained * 1,
            heroAttributes: PhotoViewHeroAttributes(tag: index),
            onTapUp: (context, details, controllerValue) {
              tapped = !tapped;
              setState(() {});
            },
          );
        },
        itemCount: 10,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        onPageChanged: (index) {
          tapped = false;
          currentIndex = index;
          setState(() {});
        },
        pageController: PageController(initialPage: widget.initialIndex),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String url;
  const CustomAppBar({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: [
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () async {
              final uri = Uri.parse(url);
              final response = await http.get(uri);
              // save the image to the device
              Directory? tempDir = await getExternalStorageDirectory();
              String tempPath = '${tempDir?.absolute.path}/temp.jpg';
              File file = File(tempPath);

              await file.writeAsBytes(response.bodyBytes).then((value) {
                FlutterShare.shareFile(
                  title: 'Share via',
                  text: 'Share',
                  filePath: value.path,
                  fileType: 'image/jpg',
                );
              });
            },
            child: const Icon(Icons.share),
          )),
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, '/qr', arguments: url);
            },
            child: const Icon(Icons.qr_code),
          )),
      // TODO: add delete button
      // TODO: add Download Button
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
