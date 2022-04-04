import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:southwind/UI/home/career_tab/components/information_dialog.dart';

class Showimage extends StatelessWidget {
  final String imageurl;
  const Showimage({Key? key, required this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(imageurl),
        ),
      ),
    );
  }
}

class NetworkImagesLoader extends StatelessWidget {
  String url;
  BoxFit? fit;
  double? radius;
  NetworkImagesLoader(
      {required this.url, this.fit = BoxFit.cover, this.radius = 0.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Showimage(imageurl: url)));
        //Showimage(imageurl: url);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.network(
          url,
          fit: fit,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              child: Center(
                  child: Text(
                "Can't load the image",
                maxLines: 1,
                overflow: TextOverflow.clip,
              )),
            );
          },
        ),
      ),
    );
  }
}

class videoNetworkImagesLoader extends StatelessWidget {
  String url;
  BoxFit? fit;
  double? radius;
  videoNetworkImagesLoader(
      {required this.url, this.fit = BoxFit.cover, this.radius = 0.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.network(
          url,
          fit: fit,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              child: Center(
                  child: Text(
                "Can't load the image",
                maxLines: 1,
                overflow: TextOverflow.clip,
              )),
            );
          },
        ),
      ),
    );
  }
}
