import 'package:flutter/material.dart';

class AddAchievement extends StatefulWidget {
  const AddAchievement({super.key});

  @override
  State<AddAchievement> createState() => _AddAchievementState();
}

class _AddAchievementState extends State<AddAchievement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: const [
            Text(
              'Add',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' Achievement',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFABBAAB), width: 1.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Start typing...",
                  border: InputBorder.none,
                ),
                minLines: 6,
                maxLength: 10,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Color(0xFF2C3E50),
                cursorWidth: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
