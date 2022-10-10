import 'dart:ui';

import 'package:animated_button/utils/responsive.dart';
import 'package:flutter/material.dart';



class CustomAnimatedButton extends StatefulWidget {

  const CustomAnimatedButton({super.key});

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton> {

  double xPosition = 0;
  double yPosition = 0;
  bool dragging = false;
  int counter = 0;

  void setXValue(final double value, final bool dragging){
    setState(() {
      xPosition = value;
      this.dragging = dragging;
    });
  }

  void setYValue(final double value, final bool dragging){
    setState(() {
      yPosition = value;
      this.dragging = dragging;
    });
  }

  void incrementOrDecrement(final int value) => counter += value;
  void clearCount() => counter = 0;

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    // Parent container
    final double containerXPostion = xPosition.clamp(-resp.wp(2), resp.wp(2));
    final double containerYPostion = yPosition.clamp(-resp.hp(1), resp.hp(1));

    // Center button
    final double centerButtonWidthLimits = resp.wp(12.25) - containerXPostion.abs();
    final double centerButtonHeightLimits = resp.hp(6) - containerYPostion.abs();

    xPosition = xPosition.clamp(-centerButtonWidthLimits, centerButtonWidthLimits);
    yPosition = yPosition.clamp(-centerButtonHeightLimits, centerButtonHeightLimits);

    final bool canAddOrRemove = xPosition.abs() >= centerButtonWidthLimits;
    final bool canDeleteCount = yPosition.abs() >= centerButtonHeightLimits;

    // Other elements
    final double percent = xPosition != 0 ? (xPosition / centerButtonWidthLimits).abs().toDouble() : (yPosition / centerButtonHeightLimits).abs().toDouble();
    final double opacity = (1 - percent).clamp(0.1, 1);

    return AnimatedContainer(
      duration: Duration(milliseconds: dragging ? 500 : 800),
      transform: Matrix4.identity()..translate(containerXPostion, containerYPostion),
      curve: Curves.ease,
      height: resp.hp(8),
      width: resp.wp(40),
      decoration: const BoxDecoration(
        color: Color(0xff202021),
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.delete, color: const Color(0xff4d4d4c).withOpacity(yPosition != 0 ? (1 - opacity) : 0)),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(Icons.remove, color: const Color(0xff4d4d4c).withOpacity(opacity)),
                  onPressed: () => setState(() => incrementOrDecrement(-1)),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setXValue(xPosition + details.delta.dx, true);
                  },
                  onVerticalDragUpdate: (details) {
                    if(xPosition == 0){
                      setYValue(yPosition + details.delta.dy, true);
                    }
                  },
                  onHorizontalDragEnd: (details){
                    if(canAddOrRemove){
                      incrementOrDecrement(xPosition < 0 ? -1 : 1);
                    }
                    setXValue(0, false);
                  },
                  onVerticalDragEnd: (details) {
                    if(canDeleteCount){
                      clearCount();
                    }
                    setYValue(0, false);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: dragging ? 50 : 700),
                    curve: dragging ? Curves.linear : Curves.easeInOutBack,
                    transform: Matrix4.identity()..translate(xPosition, yPosition),
                    child: Container(
                      height: resp.hp(6),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xff3a3b3a),
                        shape: BoxShape.circle,
                      ),
                      child: Text(counter.toString(), style: const TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                )
              ),
              Expanded(
                child: IconButton(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(Icons.add, color: const Color(0xff4d4d4c).withOpacity(opacity)),
                  onPressed: () => setState(() => incrementOrDecrement(1)),
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}