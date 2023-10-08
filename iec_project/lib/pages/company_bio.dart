import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iec_project/controllers/auth_controller.dart';
import 'package:iec_project/controllers/companybio_controller.dart';
import 'package:iec_project/utils/gradients.dart';
import 'package:image_picker/image_picker.dart';

class CompanyBio extends StatefulWidget {
  const CompanyBio({super.key});

  @override
  State<CompanyBio> createState() => _CompanyBioState();
}

class _CompanyBioState extends State<CompanyBio> {
  String? name, bio, email, number;
  CompanyController dbcontroller = Get.put(CompanyController());
  // Authcontroller _authi = Get.put(Authcontroller());
  File? _image;
  ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  _UserImagePicker(_ImagePicker ip) async {
    final pick;
    switch (ip) {
      case _ImagePicker.camera:
        pick = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        break;
      case _ImagePicker.gallery:
        pick = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 25);
        break;
    }

    _image = File(pick.path);
    if (pick != null) {
      _image = File(pick.path);
    } else {
      print("No image is selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: gradeGrey),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tell us about yourself!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
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
                                          _UserImagePicker(_ImagePicker.camera);
                                          Navigator.pop(ctx);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text("Gallery"),
                                        onTap: () {
                                          _UserImagePicker(
                                              _ImagePicker.gallery);
                                          Navigator.pop(ctx);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                child: _image == null
                                    ? Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                      )
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller:
                                  CompanyController.instance.nameController,
                              cursorColor: const Color(0xFF2C3E50),
                              cursorWidth: 1.0,
                              decoration: const InputDecoration(
                                labelText: "Company ",
                                labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                                hintText: "your name",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the field is empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              maxLines: 3,
                              controller:
                                  CompanyController.instance.bioController,
                              cursorColor: const Color(0xFF2C3E50),
                              cursorWidth: 1.0,
                              decoration: const InputDecoration(
                                labelText: "Bio Description",
                                labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                                hintText: "your bio description",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter bio";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                bio = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller:
                                  CompanyController.instance.emailController,
                              cursorColor: const Color(0xFF2C3E50),
                              cursorWidth: 1.0,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                                hintText: "your email",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the value should not be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller:
                                  CompanyController.instance.contactController,
                              cursorColor: const Color(0xFF2C3E50),
                              cursorWidth: 1.0,
                              decoration: const InputDecoration(
                                labelText: "contact",
                                labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                                hintText: "your contact no",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the field should not be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                number = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[600])),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  String url = await dbcontroller
                                      .uploadCompanyImage(_image!);

                                  dbcontroller.uploadData(url);
                                }
                              },
                              child: dbcontroller.isUploading.isTrue
                                  ? Center(child: CircularProgressIndicator())
                                  : Text(
                                      "Submit",
                                      style: TextStyle(fontSize: 16),
                                    ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

enum _ImagePicker { camera, gallery }
