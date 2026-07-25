// TODO Implement this library.
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;

  const AvatarWidget({
    super.key,
    required this.initials,
    required this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.36,
        ),
      ),
    );
  }
}
