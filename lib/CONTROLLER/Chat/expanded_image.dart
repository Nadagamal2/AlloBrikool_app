import 'package:flutter/material.dart';

class ExpandedImage extends StatelessWidget {
   ExpandedImage({Key? key,required this.image}) : super(key: key);
  String image;
  @override
  Widget build(BuildContext context) {
    return Image.network(image);
  }
}