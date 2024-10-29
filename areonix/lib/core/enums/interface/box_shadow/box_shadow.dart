import 'package:flutter/material.dart';

enum BoxShadowType {
  light,
  medium,
  heavy;

  List<BoxShadow> get boxShadow {
    switch (this) {
      case BoxShadowType.light:
        return [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ];
      case BoxShadowType.medium:
        return [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ];
      case BoxShadowType.heavy:
        return [
          const BoxShadow(
            color: Colors.black45,
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ];
    }
  }
}
