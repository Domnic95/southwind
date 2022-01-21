import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:southwind/UI/home/chat_tab/single_chat_screen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoApp extends StatefulWidget {
  final String url;

  const FullScreenVideoApp({required this.url});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<FullScreenVideoApp> {
  late VideoPlayerController _controller;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          isPlay = true;
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final _groupProvider = context.read(groupProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(_groupProvider
            .listGroup[_groupProvider.selectedGroupIndex!].group!.groupName!),
        elevation: 20,
      ),
      body: Center(
          child: InkWell(
              onTap: () {
                setState(() {
                  isPlay ? _controller.pause() : _controller.play();
                });
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
