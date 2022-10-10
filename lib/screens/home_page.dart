import 'package:animated_button/utils/responsive.dart';
import 'package:animated_button/widgets/custom_animated_button.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final hPadding = resp.wp(2.5);
    final vPadding = resp.hp(5);

    return Scaffold(
      backgroundColor: const Color(0xff2d2d2c),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Animated button', style: TextStyle(fontSize: 35, color: Colors.white)),
              SizedBox(height: resp.hp(5)),
              const CustomAnimatedButton()
            ],
          ),
        ),
      ),
    );
  }
}