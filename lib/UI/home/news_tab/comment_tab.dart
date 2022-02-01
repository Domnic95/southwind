import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/news/comment_modal.dart';
import 'package:southwind/Models/news/postModal.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/chat_tab/components/FullScreenImage.dart';
import 'package:southwind/UI/home/chat_tab/components/FullscreenVideo.dart';
import 'package:southwind/UI/home/chat_tab/single_chat_screen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';

class CommentTab extends StatefulHookWidget {
  final PostModal postModal;
  const CommentTab(this.postModal, {Key? key}) : super(key: key);
  @override
  _CommentTabState createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  TextEditingController textController = TextEditingController();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context
        .read(commentNotifierProvider(widget.postModal.id.toString()))
        .loadComments();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentNotifier =
        useProvider(commentNotifierProvider(widget.postModal.id.toString()));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primarySwatch[900]),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? LoadingWidget()
          : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: commentNotifier.comments.isEmpty
                      ? const Center(
                          child: Text("No Comment Found"),
                        )
                      : ListView.builder(
                          itemCount: commentNotifier.comments.length,
                          itemBuilder: (context, index) {
                            return CommentWidget(
                              commentModal: commentNotifier.comments[index],
                            );
                          }),
                ),
                Container(
                  // height: 60,
                  // constraints: BoxConstraints(maxHeight: 100),
                  // decoration: BoxDecoration(
                  //   color: primarySwatch[100],
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(20),
                  //       topRight: Radius.circular(20)),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 18),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: primarySwatch.shade900),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                maxLines: 4,
                                minLines: 1,
                                decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Icon(Icons.file_copy),

                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    fillColor: Colors.transparent,
                                    hintText: "Send Message",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    isCollapsed: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: .5,
                                            color: Colors.transparent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: .5,
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    // backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          bottomSheetWidget(() async {
                                            await commentNotifier.imageUpload(
                                                ImageSource.gallery,
                                                widget.postModal.id.toString());
                                          }, "Gallery"),
                                          Divider(
                                            color: primarySwatch.shade800,
                                          ),
                                          bottomSheetWidget(() async {
                                            await commentNotifier.imageUpload(
                                                ImageSource.camera,
                                                widget.postModal.id.toString());
                                          }, "Camera"),
                                          Divider(
                                            color: primarySwatch.shade800,
                                          ),
                                          bottomSheetWidget(() async {
                                            await commentNotifier.videoUpload(
                                                ImageSource.camera,
                                                widget.postModal.id.toString());
                                          }, "Video")
                                        ],
                                      );
                                    });
                              },
                              child: Image.asset(
                                "assets/images/attachments.png",
                                color: primarySwatch[900],
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            // Icon(Icons.send_outlined),
                            InkWell(
                              onTap: () async {
                                print('heelo');
                                await commentNotifier.sendComment(
                                    widget.postModal.id.toString(),
                                    textController.text);
                                textController.clear();
                              },
                              child: Image.asset(
                                "assets/images/send.png",
                                color: primarySwatch[900],
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    ));
  }

  Widget bottomSheetWidget(VoidCallback voidCallback, String title) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        voidCallback();
      },
      child: Container(
        decoration: BoxDecoration(),
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final CommentModal commentModal;
  const CommentWidget({required this.commentModal, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            NetworkImage("${commentModal.profile.userImage}"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${commentModal.profile.profileFirstName}",
                              style: TextStyle(fontSize: 14),
                            ),
                            Builder(builder: (context) {
                              switch (commentModal.mediaType!) {
                                case MediaTypes.message:
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      "\"${commentModal.comment}\"",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  );

                                case MediaTypes.Image:
                                  return CommentImage(
                                    mediaUrl: commentModal.mediaUrl,
                                  );
                                case MediaTypes.Video:
                                  return CommentVideoApp(
                                    mediaUrl: commentModal.mediaUrl,
                                  );
                              }
                            }),
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.6,
                            //   child: Text(
                            //     "\"${commentModal.comment}\"",
                            //     maxLines: 2,
                            //     style:
                            //         TextStyle(fontSize: 12, color: Colors.grey),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "${commentModal.timeDifference}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          indent: 60,
        ),
      ],
    );
  }
}

double aspectratio = 0.2;

class CommentImage extends StatelessWidget {
  final String mediaUrl;
  const CommentImage({required this.mediaUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShowImageScreen(
            mediaUrl: mediaUrl,
            title: '',
          );
        }));
      },
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          height: size.height * aspectratio,
          width: size.width * aspectratio,
          child: Image.network(
            mediaUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
    ;
  }
}

class CommentVideoApp extends StatefulWidget {
  final String mediaUrl;
  const CommentVideoApp({required this.mediaUrl});
  @override
  _CommentVideoAppState createState() => _CommentVideoAppState();
}

class _CommentVideoAppState extends State<CommentVideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.mediaUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BorderRadius borderRadius = BorderRadius.circular(radius);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FullScreenVideoApp(
            url: widget.mediaUrl,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius),
        height: size.height * aspectratio,
        width: size.width * aspectratio,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: borderRadius, child: VideoPlayer(_controller)),
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primarySwatch.shade300),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.play_arrow),
                    ))),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
