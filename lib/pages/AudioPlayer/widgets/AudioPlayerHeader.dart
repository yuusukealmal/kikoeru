// flutter
import 'package:flutter/material.dart';

Widget Header() {
  return Positioned(
    top: 40,
    left: 0,
    right: 0,
    child: Container(
      height: 20,
      color: Colors.grey[300],
      child: Center(
        child: Container(
          width: 40,
          height: 5,
          color: Colors.grey[600],
        ),
      ),
    ),
  );
}
