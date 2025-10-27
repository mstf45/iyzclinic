import 'package:flutter/cupertino.dart';

final class CustomSizedBoxWidth extends SizedBox {
  const CustomSizedBoxWidth._();

  //  Width
  const CustomSizedBoxWidth.small({super.key}) : super(width: 8);
  ////  Medium
  const CustomSizedBoxWidth.medium({super.key}) : super(width: 16);
  //  large
  const CustomSizedBoxWidth.large({super.key}) : super(width: 24);
}

final class CustomSizedBoxHeight extends SizedBox {
  const CustomSizedBoxHeight._();

  //  Height
  const CustomSizedBoxHeight.small({super.key}) : super(height: 8);
  //  Medium
  const CustomSizedBoxHeight.medium({super.key}) : super(height: 16);
  //  large
  const CustomSizedBoxHeight.large({super.key}) : super(height: 24);
}
