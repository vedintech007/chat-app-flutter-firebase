import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.btnText,
    this.btnWidth,
    this.btnHeight,
    this.borderRaduis,
    this.btnBackgroundColor,
    this.btnTextStyle,
    this.onPressed,
    this.shape,
  }) : super(key: key);

  final String? btnText;
  final double? btnWidth;
  final double? btnHeight;
  final double? borderRaduis;
  final Color? btnBackgroundColor;
  final TextStyle? btnTextStyle;
  final Function()? onPressed;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(btnWidth ?? MediaQuery.of(context).size.width / 1.1, btnHeight ?? 50),
        backgroundColor: btnBackgroundColor ?? Theme.of(context).primaryColor,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRaduis ?? 4),
            ),
      ),
      child: Text(
        btnText ?? "",
        style: btnTextStyle ??
            const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
      ),
    );
  }
}
