import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 14.0),
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
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  customBorder: const CircleBorder(),
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
                        });
                  },
                  child: CircleAvatar(
                    radius: 60,
                    foregroundImage: _image != null ? FileImage(_image!) : null,
                    // backgroundColor: ,
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: "Shahzad Haider",
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 13, 71, 161),
                              width: 2),
                        ),
                        labelText: "name"),
                  ),
                )
              ],
            ),
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
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    setState(() {
      _image = File(croppedFile!.path);
    });
  }
}

enum _ImagePicker {
  camera,
  gallery,
}
