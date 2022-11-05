import 'package:flutter/material.dart';

Gradient moonlitAestroid = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: [
    Color(0xFF0F2027),
    Color(0xFF203A43),
    Color(0xFF2C5364),
  ],
  tileMode: TileMode.mirror,
);

Gradient portrait = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFEEF2F3),
    Color(0xFF8E9EAB),
  ],
  tileMode: TileMode.mirror,
);

Gradient metallicToad = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFABBAAB),
    Color(0xFFFFFFFF),
  ],
  tileMode: TileMode.mirror,
);

Gradient gradeGrey = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF2C3E50),
    Color(0xFFBDC3C7),
  ],
  tileMode: TileMode.mirror,
);
