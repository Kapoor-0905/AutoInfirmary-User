import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/styles.dart';

class MenuTile extends StatelessWidget {
  final String displayImage;
  final String displayText;
  final double? scale;
  final String route;
  const MenuTile(
      {super.key,
      required this.displayImage,
      required this.displayText,
      required this.route,
      this.scale});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: size.width * 0.43,
        height: size.height * 0.18,
        decoration: roundedContainerDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: size.height * 0.1,
                child: Image.asset(
                  displayImage,
                  scale: scale,
                )),
            FittedBox(
                child: Text(
              displayText,
              style: normalTextBold,
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}
