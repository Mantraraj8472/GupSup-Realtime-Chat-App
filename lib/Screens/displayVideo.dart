import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DisplayVideo extends StatefulWidget {
  final String filePath;
  const DisplayVideo({Key? key, required this.filePath}) : super(key: key);

  @override
  _DisplayVideoState createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  late VideoPlayerController _videoPlayerController;
  bool isVideoPlayerControllerInitialised = false;

  _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    // _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    setState(() {
      _videoPlayerController.value.isInitialized
          ? isVideoPlayerControllerInitialised = true
          : isVideoPlayerControllerInitialised = false;
    });
  }

  @override
  void initState() {
    // _initVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    // child: isVideoPlayerControllerInitialised
                    //     ? VideoPlayer(_videoPlayerController)
                    //     : const Center(
                    //         child: CircularProgressIndicator(),
                    //       ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                        iconSize: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.crop_rotate),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.emoji_emotions_outlined),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.title),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // _videoPlayerController.value.isPlaying
                          //     ? _videoPlayerController.pause()
                          //     : _videoPlayerController.play();
                        });
                      },
                      child: CircleAvatar(
                        radius: 33,
                        backgroundColor: Colors.black38,
                        child: Icon(
                          Icons.play_arrow,
                          // _videoPlayerController.value.isPlaying
                          //     ? Icons.pause
                          //     : Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  color: Color(0xffF5F5F5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0, bottom: 4),
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Color(0xffE2E2E2),
                            child: Icon(
                              Icons.camera_alt,
                              color: Color(0xff4E5152),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.only(
                              top: 8,
                              left: 2,
                              right: 2,
                              bottom: 22,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: const Color(0xffF5F5F5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Add a caption...',
                                  contentPadding: EdgeInsets.only(bottom: 6),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            left: 4,
                            right: 2,
                            bottom: 20,
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xffE76F52),
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
