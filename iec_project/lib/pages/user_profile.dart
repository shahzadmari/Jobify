import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/pages/add_achievement.dart';
import 'package:iec_project/utils/info_box.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _image;

  List<Widget> _skills = [];
  List<Map<String, dynamic>> _achievementCards = [];

  TextEditingController _skillNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: const [
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' Profile',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          elevation: 0.0,
          titleSpacing: 0.0,
          backgroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_image == null) return;
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return Dialog(
                                backgroundColor: Colors.black,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  height:
                                      MediaQuery.of(context).size.width - 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(_image!),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          foregroundImage:
                              _image != null ? FileImage(_image!) : null,
                          backgroundColor: const Color(0xFF2C5364),
                          child: const Icon(
                            Icons.supervised_user_circle,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkResponse(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text("Camera"),
                                      onTap: () {
                                        _imagePicker(_ImagePicker.camera);
                                        Navigator.pop(ctx);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text("Gallery"),
                                      onTap: () {
                                        _imagePicker(_ImagePicker.gallery);
                                        Navigator.pop(ctx);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Danish Anodher",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              // "danishkh253@gmail.com",
                              FirebaseAuth.instance.currentUser!.email!,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Skills",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _skillChips(),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Achievements",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      child: _achievementCards.isNotEmpty
                          ? ListView.builder(
                              itemCount: _achievementCards.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return _achievementCard();
                              },
                            )
                          : Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF203A43),
                                ),
                                child: const Text(
                                  "Add Achievement",
                                  style: TextStyle(fontSize: 13),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const AddAchievement(),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _imagePicker(_ImagePicker ip) async {
    final ImagePicker _picker = ImagePicker();
    XFile? img;

    switch (ip) {
      case _ImagePicker.camera:
        img = await _picker.pickImage(source: ImageSource.camera);
        break;
      case _ImagePicker.gallery:
        img = await _picker.pickImage(source: ImageSource.gallery);
        break;
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: img!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );

    setState(() {
      _image = File(croppedFile!.path);
    });
  }

  Widget _achievementCard() {
    return GestureDetector(
      onTap: () {
        InfoBox(
          "Unimplemented Error",
          context: context,
          infoCategory: InfoCategory.error,
        );
      },
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2C5364),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Achievement',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _skillChips() {
    return LimitedBox(
      maxHeight: 175,
      child: ListView(
        children: [
          Wrap(
            spacing: 10.0,
            children: [
              GestureDetector(
                onTap: () {
                  _addSkill();
                },
                child: const Chip(
                  avatar: Icon(Icons.add),
                  label: Text("Add Skill"),
                ),
              ),
              ..._skills,
            ],
          ),
        ],
      ),
    );
  }

  void _addSkill() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Wrap(
          children: [
            const Text(
              'Skill Name',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            TextField(
              maxLength: 20,
              autofocus: true,
              controller: _skillNameController,
              decoration: const InputDecoration(
                hintText: 'e.g Flutter',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              cursorColor: Colors.grey,
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  splashFactory: InkRipple.splashFactory,
                  child: Container(
                    height: 36,
                    alignment: Alignment.center,
                    child: const Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('Add'),
                  onPressed: () {
                    setState(() {
                      _skills.add(
                        Chip(
                          label: Text(_skillNameController.text),
                          backgroundColor: Color(Random().nextInt(0xffffffff)),
                        ),
                      );
                      _skillNameController.text = "";
                      InfoBox(
                        "Skill Added Succefully",
                        context: context,
                        infoCategory: InfoCategory.success,
                      );
                    });
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _ImagePicker {
  camera,
  gallery,
}
