import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:iec_project/utils/constants.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // showInformationDialog(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (ctx) {
              return Container(
                padding: const EdgeInsets.all(12.0),
                height: MediaQuery.of(context).size.height * 0.7,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Type Recruitment'),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Start typing something..."),
                      minLines:
                          6, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'create',
        ),
        backgroundColor: ColorConstants.UiColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Text(
                  'Companies',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: "Search here",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ))
              ],
            ),
            const SizedBox(
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
                                          "${snapshot.data![index].id}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("nextgen@gmail.com"),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("2+y exp"),
                                            const Text(
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
