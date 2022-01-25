import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:southwind/Models/MessageModel.dart';
import 'package:southwind/UI/home/chat_tab/single_chat_screen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class GroupChatScreen extends StatefulHookWidget {
  GroupChatScreen({Key? key}) : super(key: key);

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  bool loading = true;
  Timer? timer;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // periodic

    timer = Timer.periodic(Duration(seconds: 1), (c) async {
      await context.read(groupProvider).getIndividualGroupMessages();
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _groupProvider = useProvider(groupProvider);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: primarySwatch[900]),
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Co,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset('assets/images/southwind_logo_single.png'),
                  //  Image.network(
                  //   "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                  // ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Center(
              child: Text(
                _groupProvider.listGroup[_groupProvider.selectedGroupIndex!]
                    .group!.groupName!,
                style: TextStyle(fontSize: 18, color: primarySwatch[900]),
              ),
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const SizedBox(
            //       height: 5,
            //     ),
            //   ],
            // )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.groupInfo);
                },
                child: Icon(Icons.more_vert_outlined)),
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  bool isLeft = _groupProvider.listOfMessage[index].profileId ==
                      _groupProvider.userData!.id;
                  return SingleMessage(
                    isGroup: true,
                    index: index,
                    messageModel: _groupProvider.listOfMessage[index],
                  );
                },
                itemCount: _groupProvider.listOfMessage.length,
              ),
            ),
            // Expanded(child: ListView.builder(itemBuilder: (context, index) {
            //   return Container();
            // })),
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
                                        width: .5, color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: .5, color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent))),
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
                                        await _groupProvider
                                            .imageUpload(ImageSource.gallery);
                                      }, "Gallery"),
                                      Divider(
                                        color: primarySwatch.shade800,
                                      ),
                                      bottomSheetWidget(() async {
                                        await _groupProvider
                                            .imageUpload(ImageSource.camera);
                                      }, "Camera"),
                                      Divider(
                                        color: primarySwatch.shade800,
                                      ),
                                      bottomSheetWidget(() async {
                                        await _groupProvider
                                            .videoUpload(ImageSource.camera);
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
                            await _groupProvider
                                .sendMessage(textController.text);
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
      ),
    );
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
