// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_verse/widgets/loader.dart';

class ImagePreviewer extends StatefulWidget {
  final String imageUrl;
  const ImagePreviewer({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ImagePreviewer> createState() => _ImagePreviewerState();
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  final CustomLoader _loader = CustomLoader();
  double downloadProgress = 0;

  downloadImage() async {
    /*final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${widget.imageUrl}';

    await Dio().download(
      widget.imageUrl,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;
        setState(() {
          downloadProgress = progress;
          print(progress);
        });
      },
    );*/

    try {
      await GallerySaver.saveImage(widget.imageUrl,
          toDcim: true, albumName: 'Wallpaper-verse');
    } catch (e) {
      //OnError show snackbar.
      print('Failed to download.');
    }
    //OnComplete show snackbar.
    print('Downloaded.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/bookmark_icon.svg',
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                  onPressed: () {
                    downloadImage();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/downloads_icon.svg',
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
