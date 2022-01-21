import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class ShowImageScreen extends StatelessWidget {
  final GroupMessage messageModel;
  final bool isLeft;
  const ShowImageScreen(
      {required this.messageModel, required this.isLeft, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _groupProvider = context.read(groupProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(_groupProvider.listGroup[_groupProvider.selectedGroupIndex!].group!.groupName!),
        elevation: 20,
      ),
      body: Center(child: Image.network(messageModel.mediaUrl!)),
    );
  }
}
