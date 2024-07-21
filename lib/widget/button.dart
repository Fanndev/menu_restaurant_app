import 'package:flutter/material.dart';
import 'package:restauran_menu/ui/home.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onPress,
      this.title,
      this.height,
      this.image,
      this.width,
      this.heightimg,
      this.widthimg,});

  final String? title;
  final double? width;
  final double? height;
  final String? image;
  final double? widthimg;
  final double? heightimg;
  final VoidCallback? onPress;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: width ?? 100,
        height: height ?? 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widthimg ?? 40,
              height: heightimg ?? 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image!))),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "$title",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
