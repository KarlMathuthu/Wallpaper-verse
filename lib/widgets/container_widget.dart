// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContainerWidget extends StatelessWidget {
  final String imageUrl;
  const ContainerWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            imageUrl, fit: BoxFit.cover,
            //loading builder return shimmer.
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                height: 200,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              );
            },
            //error loading!
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                width: 200,
                color: Colors.lightBlue,
                alignment: Alignment.center,
              );
            },
          ),
        ),
      ),
    );
  }
}
