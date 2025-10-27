import 'package:flutter/material.dart';

final class CustomDecorationBox extends BoxDecoration {
  const CustomDecorationBox({
    super.color,
    super.borderRadius,
    super.border,
    super.gradient,
  });
  CustomDecorationBox.main()
    : super(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
      );
  CustomDecorationBox.homeView()
    : super(
        border: Border.all(width: 1,),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );
}
