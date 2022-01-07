import 'package:flutter/material.dart';

class NetworkImagesLoader extends StatelessWidget {
  String url;
  BoxFit? fit;
  double? radius;
  NetworkImagesLoader(
      {required this.url, this.fit = BoxFit.cover, this.radius = 0.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }
}
