import 'package:flutter/material.dart';

class InfoBox {
  Color? color;

  String? text;
  BuildContext context;
  InfoCategory? infoCategory;

  InfoBox(this.text, {required this.context, this.infoCategory}) {
    _show();
  }

  void _show() {
    switch (infoCategory) {
      case InfoCategory.success:
        color = Colors.green;
        break;
      case InfoCategory.warning:
        color = Colors.amber;
        break;
      case InfoCategory.error:
        color = Colors.red;
        break;
      default:
        color = Colors.white;
    }

    // ScaffoldMessenger.of(context).showMaterialBanner(
    //   MaterialBanner(
    //     content: Text(
    //       text!,
    //       style: TextStyle(color: color, fontWeight: FontWeight.bold),
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //         },
    //         icon: const Icon(Icons.close),
    //       ),
    //     ],
    //     backgroundColor: const Color(0xFF203A43),
    //   ),
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text!,
          style: TextStyle(
            color: color,
            // color: Color(0xFF203A43),
            fontWeight: FontWeight.bold,
          ),
        ),
        // backgroundColor: color,
        backgroundColor: const Color(0xFF203A43),
      ),
    );
  }
}

enum InfoCategory {
  success,
  error,
  warning,
}
