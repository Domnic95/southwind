import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/news/comment_modal.dart';
import 'package:southwind/Models/news/postModal.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class CommentTab extends StatefulHookWidget {
  final PostModal postModal;
  const CommentTab(this.postModal, {Key? key}) : super(key: key);
  @override
  _CommentTabState createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  @override
  Widget build(BuildContext context) {
    final commentNotifier =
        useProvider(commentNotifierProvider(widget.postModal.id.toString()));
    if (commentNotifier.isLoading) {
      return const Scaffold(
        body: LoadingWidget(),
      );
    }
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
      body: commentNotifier.comments.isEmpty
          ? const Center(
              child: Text("No Comment Found"),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: commentNotifier.comments.length,
                      itemBuilder: (context, index) {
                        return CommentWidget(
                          commentModal: commentNotifier.comments[index],
                        );
                      }),
                ),
              ],
            ),
    ));
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
              Container(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${commentModal.profile.profileFirstName}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "\"${commentModal.comment}\"",
                            maxLines: 2,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "${commentModal.timeDifference}",
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

class Comment {
  String image;
  String name;
  String mess;
  String time;

  Comment(
      {required this.image,
      required this.name,
      required this.mess,
      required this.time});
}

List<Comment> Comments = [
  Comment(
      image: "assets/images/chris_scott.jpeg",
      name: "Andy Majors (Kansas City)",
      mess: "Some heavy hitters here!! ",
      time: "9 hours ago"),
  Comment(
      image: "assets/images/rhonda_van.jpeg",
      name: "Shawn Smoot (Salt Lake City)",
      mess: "Get that bread brothers!!!!",
      time: "9 hours ago"),
  Comment(
      image: "assets/images/tre_daniels.jpeg",
      name: "Bryce Atagi (Salt Lake City)",
      mess: "Let's go!! Amazing month to all!! the future is bright",
      time: "9 hours ago"),
  Comment(
      image: "assets/images/rhonda_van.jpeg",
      name: "jscob wilkinson (Salt Lake City)",
      mess: "Way to go everyone!!And nice job Jon! Way to represent SLC",
      time: "9 hours ago"),
  Comment(
      image: "assets/images/john_bonebrank.jpeg",
      name: "jonathan wood (Salt Lake City)",
      mess: "Those are some stats! Great work Southwind",
      time: "5 hours ago"),
];
