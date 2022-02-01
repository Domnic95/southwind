import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class ShowImageScreen extends StatelessWidget {
  final String mediaUrl;
  final String title;

  const ShowImageScreen({required this.mediaUrl,
  required this.title,
   Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(title),
        elevation: 20,
      ),
      body: Center(child: Image.network(mediaUrl)),
    );
  }
}
