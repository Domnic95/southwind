import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/UI/components/PdfViewer.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

showInformationDialog(BuildContext context) {
  showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return InformationDialog();
      });
}

class InformationDialog extends StatefulHookWidget {
  const InformationDialog({Key? key}) : super(key: key);

  @override
  _InformationDialogState createState() => _InformationDialogState();
}

class _InformationDialogState extends State<InformationDialog> {
  late YoutubePlayerController _controller;
  Widget? widgets;
  bool isVideo = false;
  @override
  void dispose() {
    if (isVideo) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    CareerAchievement achievement =
        context.read(carerNotifierProvider).selectedAchievement;
    if (achievement.resourceVideoLink != null &&
        achievement.resourceVideoLink != '') {
      print('youtube');
      _controller = YoutubePlayerController(
        initialVideoId: achievement.resourceVideoLink!.split('watch?v=')[1],
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
      isVideo = true;
      widgets = YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,

        // videoProgressIndicatorColor: Colors.amber,
        // progressColors: ProgressColors(
        //     playedColor: Colors.amber,
        //     handleColor: Colors.amberAccent,
        // ),
        // onReady (v) {
        //     _controller.addListener(listener);
        // },
      );
    } else if (achievement.cloudinarySecureUrl != "" &&
        achievement.cloudinarySecureUrl != null) {
      print('pdf');
      PDFDocument document = await PDFDocument.fromURL(
        achievement.cloudinarySecureUrl!,
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
      widgets = PdfViwer(
        height: 200,
        document: document,
      );
    } else if (achievement.cloudinaryAudioSecureUrl != "" &&
        achievement.cloudinaryAudioSecureUrl != null) {
      print('audio');
      widgets = Text('Audio');
    } else {
      widgets = Text('No data found');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  children: [
                    Expanded(child: Center(child: widgets!)),
                    CommonButton(
                      lable: "Continue",
                      ontap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/images/demo.png"),
              //         fit: BoxFit.cover),
              //     color: Colors.white,
              //   ),
              // ),
              Positioned(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ),
                right: 5,
                top: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
