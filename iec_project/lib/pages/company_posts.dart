import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iec_project/Widgets/header.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:http/http.dart' as http;

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  List<UserModel> userModelLish = [];

  Future<List<UserModel>> getSupport() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print("got the data");
      for (Map<String, dynamic> i in data) {
        userModelLish.add(UserModel.fromJson(i));
      }

      return userModelLish;
    } else {
      return userModelLish;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Heading(value: "Companies"),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: "Search here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: FutureBuilder(
                    future: getSupport(),
                    builder:
                        (context, AsyncSnapshot<List<UserModel>> snapshot) {
                      return ListView.builder(
                        itemCount: userModelLish.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 70,
                                        height: 70,
                                        child: Image.network(
                                            "${snapshot.data![index].url}")),
                                    Column(
                                      children: [
                                        Text(
                                          "Next Generation",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(height: 10),
                                        Text("nextgen@gmail.com"),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("2+y exp"),
                                            Text(
                                              " | ",
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              " Flutter Developer",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[900]),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }))
          ],
        ),
      ),
    ));
  }
}
