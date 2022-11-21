import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ShareScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ShareScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  late CameraController controller;
  XFile? pictureFile;
  int cameraIndex = 0;

  @override
  void initState() {
    super.initState();
    controller =
        CameraController(widget.cameras[cameraIndex], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _toggleCameraLens() {
    cameraIndex = cameraIndex == 0 ? 1 : 0;
    controller =
        CameraController(widget.cameras[cameraIndex], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
              ),
              IconButton(
                onPressed: () async {
                  await controller.takePicture().then((value) =>
                      Navigator.pushNamed(context, '/picture',
                          arguments: value));
                },
                icon: const Icon(Icons.camera_alt),
              ),
              IconButton(
                onPressed: () {
                  // swap camera
                  _toggleCameraLens();
                },
                icon: const Icon(Icons.switch_camera),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
