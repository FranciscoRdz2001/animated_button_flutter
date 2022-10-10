


import 'package:flutter/cupertino.dart';

class ResponsiveUtil{

  late final double height;
  late final double width;

  ResponsiveUtil({
    required final BuildContext context
  }){
    final size = MediaQuery.of(context).size;

    height = size.height;
    width = size.width;
  }

  factory ResponsiveUtil.of(final BuildContext context) => ResponsiveUtil(context: context);

  double hp(final double percent) => height * (percent / 100);
  double wp(final double percent) => width * (percent / 100);
}