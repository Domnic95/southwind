import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/news/postModal.dart';
import 'package:southwind/Models/news/singleNews.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';

import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/news_tab/comment_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/component/bottom_navigation.dart';
import 'package:southwind/component/navigationtheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:southwind/data/providers/news_notifier.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';

const String profilePath = "assets/images/image2.jpg";

class NewsScreen extends StatefulHookWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedIndex = 0;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(newsNotifierProvider).fetchNews();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _newsNotifier = useProvider(newsNotifierProvider);
    // return SingleChildScrollView(child: FeedPost());
    return Scaffold(
        body: loading
            ? LoadingWidget()
            : _newsNotifier.total_news.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 3),
                    itemBuilder: (context, index) {
                      return FeedPost(
                        post: _newsNotifier.total_news[index],
                        index: index,
                      );
                    },
                    itemCount: _newsNotifier.total_news.length,
                  )
                : Center(
                    child: Text('No news found'),
                  )
        // FutureBuilder(
        //     future: _newsNotifier.fetchNews(),
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         return ListView.builder(
        //           padding: EdgeInsets.only(top: 3),
        //           itemBuilder: (context, index) {
        //             return FeedPost(post: _newsNotifier.total_news[index]);
        //           },
        //           itemCount: _newsNotifier.total_news.length,
        //         );
        //       } else {
        //         return LoadingWidget();
        //       }
        //     }),
        // bottomNavigationBar: FFNavigationBar(
        //   theme: FFNavigationBarTheme(
        //     barBackgroundColor: Colors.white,
        //     selectedItemBackgroundColor: primarySwatch[50]!,
        //     selectedItemIconColor: Colors.black,
        //     selectedItemLabelColor: Colors.black,
        //   ),
        //   selectedIndex: selectedIndex,
        //   onSelectTab: (index) {
        //     setState(() {
        //       selectedIndex = index;
        //     });
        //   },
        //   items: [
        //     FFNavigationBarItem(
        //       iconData: Icons.feed_outlined,
        //       label: 'News',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.schedule_outlined,
        //       label: 'Schedule',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.school_outlined,
        //       label: 'Career',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.groups_outlined,
        //       label: 'Team',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.account_circle_outlined,
        //       label: 'Settings',
        //     ),
        //   ],
        // ),
        );
  }
}

class FeedPost extends StatefulWidget {
  PostModal post;
  int index;

  FeedPost({
    required this.post,
    required this.index,
  });

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  int currentIndex = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _newsNotifier = context.read(newsNotifierProvider);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 00),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.post.userImage!,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.firstName!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.post.timeDifference}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black38),
                      ),
                      Text(
                        "${widget.post.title}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // const Icon(Icons.more_vert),
                  // IconButton(onPressed: () {}, icon: )
                ],
              ),
            ),
            if (widget.post.resourceUrl != null)
              Container(
                width: size.width,
                constraints: BoxConstraints(maxHeight: size.height * .60),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MultipleImageView(
                      images: [widget.post.resourceUrl],
                      mediaType: MediaType.IMAGE,
                      Pagecontroller: controller,
                      onIndexChanged: (a) {
                        currentIndex = a;

                        setState(() {});
                      },
                    )),
              ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            !widget.post.liked!
                                ? _newsNotifier.like(widget.index)
                                : _newsNotifier.dislike(widget.index);
                          },
                          child: Icon(widget.post.liked!
                              ? Icons.favorite
                              : Icons.favorite_border)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${widget.post.likesCount}"),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentTab(widget.post),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.comment),
                              onPressed: () {
                                log(widget.post.id.toString());
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CommentTab(widget.post),
                                  ),
                                );
                              },
                            ),
                            const Text("comment"),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      // const Text("comment"),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ImageIndicator(
                        pageController: controller, totalIndex: 1),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            DescriptionTextWidget(
              sender: widget.post.firstName,
              text: widget.post.notificationText!,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: RichText(
            //             maxLines: 3,
            //             overflow: TextOverflow.ellipsis,
            //             text: TextSpan(
            //               children: [
            //                 TextSpan(
            //                     text: "${widget.post.firstName}  ",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyText1!
            //                         .copyWith(
            //                             fontWeight: FontWeight.w600,
            //                             fontSize: 14)),
            //                 WidgetSpan(
            //                     alignment: PlaceholderAlignment.baseline,
            //                     baseline: TextBaseline.alphabetic,
            //                     child: DescriptionTextWidget(
            //                       text: widget.post.notificationText!,
            //                     )),
            //                 // TextSpan(ss
            //                 //   text: widget.post.notificationText!.length
            //                 //       .toString(),
            //                 //   style: TextStyle(
            //                 //     fontWeight: FontWeight.w600,
            //                 //     fontSize: 14,
            //                 //     color: Colors.black.withOpacity(.8),
            //                 //   ),
            //                 // ),
            //               ],
            //             )),
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageIndicator extends StatefulWidget {
  final int totalIndex;
  final PageController pageController;
  const ImageIndicator(
      {required this.pageController, required this.totalIndex, Key? key})
      : super(key: key);

  @override
  _ImageIndicatorState createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends State<ImageIndicator> {
  int currentIndex = 0;
  double width = 40;
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    widget.pageController.addListener(() {
      if (mounted) {
        setState(() {
          currentIndex = widget.pageController.page!.round();
        });
      }
      setScoll();
    });
    super.initState();
  }

  setScoll() {
    controller.animateTo(((6 - 2) * currentIndex).toDouble(),
        duration: Duration(milliseconds: 80), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !(widget.totalIndex > 1)
          ? Container()
          : Container(
              height: 50,
              width: width,
              child: SingleChildScrollView(
                controller: controller,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int a = 0; a < widget.totalIndex; a++)
                      Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : primaryColor)
                                    .withOpacity(a == currentIndex ? .9 : 0.4)),
                      )
                  ],
                )),
              ),
            ),
    );
  }
}

class MultipleImageView extends StatefulWidget {
  final List<String> images;
  final MediaType mediaType;

  final Function(int) onIndexChanged;
  final PageController Pagecontroller;
  const MultipleImageView(
      {required this.images,
      required this.mediaType,
      required this.Pagecontroller,
      required this.onIndexChanged,
      Key? key})
      : super(key: key);

  @override
  _MultipleImageViewState createState() => _MultipleImageViewState();
}

class _MultipleImageViewState extends State<MultipleImageView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.mediaType == MediaType.VIDEO) {
      _controller = VideoPlayerController.network(widget.images.first)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
          _controller.play();
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    if (widget.mediaType == MediaType.VIDEO) _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.length == 1) {
      return widget.mediaType == MediaType.VIDEO
          ? VideoPlayer(_controller)
          : NetworkImagesLoader(
              url: widget.images.first,
              fit: BoxFit.cover,
            );
    }
    return Container(
      child: PageView(
        controller: widget.Pagecontroller,
        onPageChanged: widget.onIndexChanged,
        children: [
          ...widget.images
              .map((e) => NetworkImagesLoader(
                    url: e,
                    fit: BoxFit.cover,
                  ))
              .toList(),
        ],
      ),
    );
    // return CarouselSlider.builder(
    //     itemCount: images.length,
    //     itemBuilder: (con, a, b) {
    //       return Image.network(
    //         images[a],
    //         fit: BoxFit.cover,
    //       );
    //     },
    //     options: CarouselOptions(
    //       viewportFraction: 1,
    //       enlargeCenterPage: false,
    //     ));
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String? sender;
  String? text;

  DescriptionTextWidget({required this.sender, required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;
  bool isLink = false;
  List listString = [];
  @override
  void initState() {
    super.initState();
    int firstTagstartIndex = widget.text!.indexOf("<br><a");
    if (firstTagstartIndex != -1) {
      // int firstTagstartIndex = widget.text!.indexOf("<br><a");
      int linkedStartIndex = widget.text!.indexOf("href='");
      int firstTagEndIndex = widget.text!.indexOf("'>", firstTagstartIndex + 1);
      int tagEndIndex = widget.text!.indexOf("</a>", firstTagEndIndex);
      String showTitle =
          widget.text!.substring(firstTagEndIndex + 2, tagEndIndex);
      String link =
          widget.text!.substring(linkedStartIndex + 6, firstTagEndIndex);
      int urlEnd = widget.text!.indexOf("</a>", firstTagEndIndex);
      String removeString =
          widget.text!.substring(firstTagstartIndex, urlEnd + 4);
      listString = widget.text!.split(removeString);
      // String remove = widget.text.split(pattern)

      widget.text = listString[0] + " ${showTitle} " + listString[1];
      isLink = true;
    }

    if (widget.text!.length > 50) {
      firstHalf = widget.text!.substring(0, 50);
      secondHalf = widget.text!.substring(50, widget.text!.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  final style = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Colors.black.withOpacity(.8),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf!.isEmpty
          ? RichText(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: widget.sender.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
                  TextSpan(
                    text: firstHalf.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black.withOpacity(.8),
                    ),
                  ),
                ],
              ))
          : new Column(
              children: <Widget>[
                RichText(
                    // overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: widget.sender.toString() + " ",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    TextSpan(
                      text: flag
                          ? (firstHalf.toString() + "...")
                          : (firstHalf.toString() + secondHalf!).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black.withOpacity(.8),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: InkWell(
                        child: Text(
                          flag ? "  more" : "  less",
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            // fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                      ),
                    ),
                  ],
                )),
                // Text(
                //   flag
                //       ? (firstHalf.toString() + "...")
                //       : (firstHalf.toString() + secondHalf!),
                //   style: style,
                // ),
              ],
            ),
    );
  }
}
