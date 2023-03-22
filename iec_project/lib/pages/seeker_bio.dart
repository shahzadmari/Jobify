import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iec_project/controllers/auth_controller.dart';
import 'package:iec_project/controllers/firestore_controller.dart';
import 'package:iec_project/controllers/storage_controller.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:iec_project/utils/gradients.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SeekerBio extends StatefulWidget {
  const SeekerBio({super.key});

  @override
  State<SeekerBio> createState() => _SeekerBioState();
}

class _SeekerBioState extends State<SeekerBio> {
  Seekers? seekers;
  dynamic expValue;
  String? name, bio, email, number;
  FirestoreController dbcontroller = Get.put(FirestoreController());
  File? _image;
  ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  int index = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;

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
    return Container(
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
                                      _UserImagePicker(_ImagePicker.gallery);
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
                              FirestoreController.instance.nameController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your name",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "the field is empty";
                            }
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
                              FirestoreController.instance.bioController,
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
                          },
                          onChanged: (value) {
                            bio = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropDownTextField(
                        dropdownRadius: 18,
                        textFieldDecoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "enter experience",
                            labelStyle: TextStyle(color: Colors.grey)),
                        controller: FirestoreController.instance.expController,
                        dropDownList: [
                          DropDownValueModel(name: " 1 year", value: "value 1"),
                          DropDownValueModel(name: " 2 year", value: "value 2"),
                          DropDownValueModel(name: " 3 year", value: "value 3"),
                          DropDownValueModel(name: " 4 year", value: "value 4"),
                          DropDownValueModel(name: " 5 year", value: "value 5"),
                        ],
                        onChanged: (value) {
                          expValue = FirestoreController
                              .instance.expController!.dropDownValue!.name;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropDownTextField.multiSelection(
                        controller: FirestoreController.instance.mController,
                        dropDownList: [
                          DropDownValueModel(name: "Java", value: "selOne"),
                          DropDownValueModel(name: "Flutter", value: "SelTwo"),
                          DropDownValueModel(
                              name: "Android", value: "selThree"),
                          DropDownValueModel(
                              name: "React.js", value: "selFour"),
                          DropDownValueModel(
                              name: "React Native", value: "selFive"),
                          DropDownValueModel(name: "Node JS", value: "selSix")
                        ],
                        textFieldDecoration: InputDecoration(
                            labelText: "enter skills ",
                            labelStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onChanged: (value) {},
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
                              FirestoreController.instance.emailController,
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
                              FirestoreController.instance.contactController,
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
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[600])),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FirestoreController
                                  .instance.mController!.dropDownValueList!
                                  .forEach((element) {
                                FirestoreController.instance.skills
                                    .add(element.name.toString());
                              });
                              String url = await uploadUserImage(_image!);
                              //   print(url);

                              //FirestoreController.instance.uploadData(name,);
                              // seekers = Seekers(
                              //     name: name,
                              //     bio: bio,
                              //     experience: expValue,
                              //     skills: skills,
                              //     email: email,
                              //     contact: number,
                              //     url: url);
                              // final docref = db
                              //     .collection('seekers')
                              //     .withConverter(
                              //         fromFirestore: Seekers.fromFirestore,
                              //         toFirestore: (Seekers seekers, options) =>
                              //             seekers.ToFirestore())
                              //     .doc(FirebaseAuth.instance.currentUser!.uid);
                              // await docref.set(seekers!);

                              dbcontroller.uploadData(url);
                            }
                          },
                          child: Text(
                            "clicked",
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
    );
  }
}

enum _ImagePicker { camera, gallery }
