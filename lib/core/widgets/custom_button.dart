import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color backgroundColor;
  final double borderRadius;
  final Widget child;
  final IconData? icon;
  final double? iconSize;

  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor = AppColor.coralRed,
    this.borderRadius = 10,
    this.icon,
    this.iconSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: iconSize) : null,
        label: child,
      ),
    );
  }
}
