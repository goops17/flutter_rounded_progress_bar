import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class RoundedProgressBar extends StatefulWidget {
  final double percent;
  final double height;
  final RoundedProgressBarStyle style;
  final RoundedProgressBarTheme theme;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry paddingChildLeft;
  final EdgeInsetsGeometry paddingChildTop;
  final EdgeInsetsGeometry paddingChildBottom;
  final EdgeInsetsGeometry paddingChildRight;
  final Widget childCenter;
  final Widget childLeft;
  final Widget childTop;
  final Widget childBottom;
  final Widget childRight;
  final bool reverse;
  final int milliseconds;
  final BorderRadiusGeometry borderRadius;

  RoundedProgressBar(
      {this.percent = 40,
      this.height = 50,
      this.style,
      this.theme,
      this.margin,
      this.reverse = false,
      this.childCenter,
      this.childLeft,
      this.childTop,
      this.childBottom,
      this.childRight,
      this.milliseconds = 500,
      this.borderRadius,
      this.paddingChildLeft,
      this.paddingChildTop,
      this.paddingChildBottom,
      this.paddingChildRight}) {
    assert(percent >= 0);
    assert(height > 0);
  }

  @override
  State<StatefulWidget> createState() => RoundedProgressBarState();
}

class RoundedProgressBarState extends State<RoundedProgressBar> {
  double width;
  double maxWidth;
  double widthProgress;
  RoundedProgressBarStyle style;
  Widget childCenter;
  AlignmentGeometry alignment = AlignmentDirectional.centerStart;
  BorderRadiusGeometry borderRadius;
  EdgeInsetsGeometry paddingChildLeft;
  EdgeInsetsGeometry paddingChildTop;
  EdgeInsetsGeometry paddingChildBottom;
  EdgeInsetsGeometry paddingChildRight;

  @override
  void initState() {
    if (widget.style == null) {
      style = RoundedProgressBarStyle();
    } else {
      style = widget.style;
    }

    if (widget.theme != null) {
      if (widget.theme == RoundedProgressBarTheme.blue) {
        style = RoundedProgressBarStyle(
            backgroundProgress: backgroundProgressDefault,
            colorProgress: colorProgressBlue,
            colorProgressDark: colorProgressBlueDark,
            colorBorder: colorBorderDefault);
      } else if (widget.theme == RoundedProgressBarTheme.red) {
        style = RoundedProgressBarStyle(
            backgroundProgress: backgroundProgressDefault,
            colorProgress: colorProgressRed,
            colorProgressDark: colorProgressRedDark,
            colorBorder: colorBorderDefault);
      } else if (widget.theme == RoundedProgressBarTheme.green) {
        style = RoundedProgressBarStyle(
            backgroundProgress: backgroundProgressDefault,
            colorProgress: colorProgressGreen,
            colorProgressDark: colorProgressGreenDark,
            colorBorder: colorBorderDefault);
      } else if (widget.theme == RoundedProgressBarTheme.purple) {
        style = RoundedProgressBarStyle(
            backgroundProgress: backgroundProgressDefault,
            colorProgress: colorProgressPurple,
            colorProgressDark: colorProgressPurpleDark,
            colorBorder: colorBorderDefault);
      } else if (widget.theme == RoundedProgressBarTheme.yellow) {
        style = RoundedProgressBarStyle(
            backgroundProgress: backgroundProgressDefault,
            colorProgress: colorProgressYellow,
            colorProgressDark: colorProgressYellowDark,
            colorBorder: colorBorderDefault);
      } else if (widget.theme == RoundedProgressBarTheme.midnight) {
        style = RoundedProgressBarStyle(
            backgroundProgress: backgroundProgressDefault,
            colorProgress: colorProgressMidnight,
            colorProgressDark: colorProgressMidnightDark,
            colorBorder: colorBorderDefault);
      }
    }

    if (widget.reverse) {
      alignment = AlignmentDirectional.centerEnd;
    }

    if (widget.borderRadius == null) {
      borderRadius = BorderRadius.circular(12);
    } else {
      borderRadius = widget.borderRadius;
    }

    if (widget.paddingChildLeft == null) {
      paddingChildLeft = EdgeInsets.all(16);
    } else {
      paddingChildLeft = widget.paddingChildLeft;
    }

    if (widget.paddingChildTop == null) {
      paddingChildTop = EdgeInsets.all(16);
    } else {
      paddingChildTop = widget.paddingChildTop;
    }

    if (widget.paddingChildBottom == null) {
      paddingChildBottom = EdgeInsets.all(16);
    } else {
      paddingChildBottom = widget.paddingChildBottom;
    }

    if (widget.paddingChildRight == null) {
      paddingChildRight = EdgeInsets.all(16);
    } else {
      paddingChildRight = widget.paddingChildRight;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    widthProgress = width * widget.percent / 100;

    return Container(
        margin: widget.margin,
        decoration:
            BoxDecoration(borderRadius: borderRadius, color: style.colorBorder),
        padding: EdgeInsets.all(style.borderWidth),
        child: Column(children: <Widget>[
          if (widget.childTop != null)
            Padding(
              padding: paddingChildTop,
              child: Align(alignment: Alignment.center, child: widget.childTop),
            ),
          Container(
              constraints: BoxConstraints.expand(height: widget.height),
              decoration: BoxDecoration(
                  borderRadius: borderRadius, color: style.backgroundProgress),
              child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Expanded(
                    child: Stack(alignment: alignment, children: <Widget>[
                  AnimatedContainer(
                      duration: Duration(milliseconds: widget.milliseconds),
                      width: widthProgress + style.widthShadow,
                      decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          color: style.colorProgressDark)),
                  AnimatedContainer(
                    duration: Duration(milliseconds: widget.milliseconds),
                    width: widthProgress,
                    decoration: BoxDecoration(
                        borderRadius: borderRadius, color: style.colorProgress),
                  ),
                  Center(child: widget.childCenter),
                  Padding(
                    padding: paddingChildLeft,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: widget.childLeft),
                  ),
                  Padding(
                    padding: paddingChildRight,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: widget.childRight),
                  )
                ]))
              ])),
          if (widget.childBottom != null)
            Padding(
              padding: paddingChildBottom,
              child:
                  Align(alignment: Alignment.center, child: widget.childBottom),
            ),
        ]));
  }
}
