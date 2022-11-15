import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iec_project/utils/gradients.dart';

class SeekerBio extends StatefulWidget {
  const SeekerBio({super.key});

  @override
  State<SeekerBio> createState() => _SeekerBioState();
}

class _SeekerBioState extends State<SeekerBio> {
  dynamic expValue;

  String skills = "";
  File? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _skillController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  SingleValueDropDownController _expController =
      SingleValueDropDownController();
  MultiValueDropDownController _mController = MultiValueDropDownController();

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
                        print("functionality is missing");
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
                              : Image.file(_image!)),
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
                        controller: _nameController,
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
                        controller: _bioController,
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
                      controller: _expController,
                      dropDownList: [
                        DropDownValueModel(name: " 1 year", value: "value 1"),
                        DropDownValueModel(name: " 2 year", value: "value 2"),
                        DropDownValueModel(name: " 3 year", value: "value 3"),
                        DropDownValueModel(name: " 4 year", value: "value 4"),
                        DropDownValueModel(name: " 5 year", value: "value 5"),
                      ],
                      onChanged: (value) {
                        expValue = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropDownTextField.multiSelection(
                      controller: _mController,
                      dropDownList: [
                        DropDownValueModel(name: "Java", value: "selOne"),
                        DropDownValueModel(name: "Flutter", value: "SelTwo"),
                        DropDownValueModel(name: "Android", value: "selThree"),
                        DropDownValueModel(name: "React.js", value: "selFour"),
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
                        controller: _emailController,
                        cursorColor: const Color(0xFF2C3E50),
                        cursorWidth: 1.0,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                          hintText: "your email",
                          border: InputBorder.none,
                        ),
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
                        controller: _contactController,
                        cursorColor: const Color(0xFF2C3E50),
                        cursorWidth: 1.0,
                        decoration: const InputDecoration(
                          labelText: "contact",
                          labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                          hintText: "your contact no",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[600])),
                        onPressed: () {
                          print("ddd");
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
    );
  }
}
