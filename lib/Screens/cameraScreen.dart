import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/displayVideo.dart';
import 'package:image_picker/image_picker.dart';
import 'displayPicture.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> _cameras;
  bool isLoading = true;
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isFlash = false;
  XFile? imageClicked;
  XFile? videoRecorded;
  bool isRecording = false;
  bool isCameraFront = false;

  Future<void> _initCamera() async {
    setState(() {
      isLoading = true;
    });
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras.first, ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        body: isLoading
            ? const SizedBox(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CameraPreview(_cameraController),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10.0, top: 5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10.0,
                                    top: 5,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isFlash == true) {
                                          isFlash = false;
                                        } else {
                                          isFlash = true;
                                        }
                                        isFlash
                                            ? _cameraController
                                                .setFlashMode(FlashMode.torch)
                                            : _cameraController
                                                .setFlashMode(FlashMode.off);
                                      });
                                    },
                                    child: Icon(
                                      isFlash == false
                                          ? Icons.flash_off_sharp
                                          : Icons.flash_on_sharp,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: InkWell(
                                      onTap: () {},
                                      child: ImageIcon(
                                        AssetImage('images/galleryIcon.jpeg'),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (isRecording == false) {
                                        try {
                                          imageClicked = await _cameraController
                                              .takePicture();
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayPicture(
                                                      imagePath:
                                                          imageClicked?.path),
                                            ),
                                          );
                                        } catch (e) {
                                          if (kDebugMode) {
                                            print(e);
                                          }
                                        }
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayPicture(imagePath: null),
                                        ),
                                      );
                                    },
                                    onLongPress: () async {
                                      await _cameraController
                                          .prepareForVideoRecording();
                                      await _cameraController
                                          .startVideoRecording();
                                      setState(() {
                                        isRecording = true;
                                      });
                                    },
                                    onLongPressUp: () async {
                                      videoRecorded = await _cameraController
                                          .stopVideoRecording();
                                      setState(() {
                                        isRecording = false;
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DisplayVideo(
                                              filePath: videoRecorded!.path),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      isRecording
                                          ? Icons.radio_button_on
                                          : Icons.panorama_fish_eye,
                                      size: 80,
                                      color: isRecording
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 50.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isCameraFront ^= true;
                                        });
                                        _cameraController = CameraController(
                                            _cameras[isCameraFront ? 1 : 0],
                                            ResolutionPreset.high);
                                      },
                                      child: Icon(
                                        CupertinoIcons.switch_camera_solid,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: Center(
                        child: Text(
                          'Long press for video, tap for photo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
