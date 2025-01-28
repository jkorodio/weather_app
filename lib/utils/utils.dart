import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatDate(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMM dd - E').format(parsedDate);
  } catch (e) {
    return date;
  }
}

class GradientBackground extends StatelessWidget {
  final bool isDarkMode;
  final Widget child;

  const GradientBackground(
      {super.key, required this.isDarkMode, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [
                  Colors.black,
                  Colors.grey[900]!,
                  Colors.grey[700]!,
                  Colors.grey[500]!,
                ]
              : [
                  Colors.blue[100]!,
                  Colors.blue[300]!,
                  Colors.blue[500]!,
                  Colors.blue[700]!,
                ],
        ),
      ),
      child: child,
    );
  }
}
