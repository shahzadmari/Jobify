import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iec_project/controllers/getpost_controller.dart';
import 'package:iec_project/controllers/post_controller.dart';
import 'package:iec_project/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  PostController _postController = Get.put(PostController());
  GetPostsController _getPostsController = Get.put(GetPostsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: (_postController.checkdoc)
          ? FloatingActionButton.extended(
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
                          const Text(
                            'Post',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: _postController.title,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                hintText: "title",
                                labelText: "enter title"),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.only(left: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xFFABBAAB), width: 1.0),
                            ),
                            child: TextFormField(
                              controller: _postController.desc,
                              decoration: const InputDecoration(
                                hintText: "Start typing...",
                                border: InputBorder.none,
                              ),
                              minLines:
                                  6, // any number you need (It works as the rows for the textarea)
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              cursorColor: const Color(0xFF2C3E50),
                              cursorWidth: 1.0,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _postController.Loc,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                hintText: "Location",
                                labelText: "enter location"),
                          ),
                          ElevatedButton(
                            child: const Text('Upload Post'),
                            onPressed: () =>
                                _postController.uploadPost(context),
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
            )
          : null,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: const [
              Text(
                'Company',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' Posts',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GetBuilder<GetPostsController>(
              init: GetPostsController(),
              initState: (_) {},
              builder: (controller) {
                controller.getPosts();

                return controller.isLoading
                    ? ListView.builder(
                        itemCount: controller.posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shadowColor: Colors.blueGrey[600],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(),
                                      title: Text(
                                        controller.posts[index].username!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          Text(controller.posts[index].email!),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Text(controller
                                                    .posts[index].description!),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .location_solid,
                                                            color: Color(
                                                                0xFF2C5364),
                                                          ),
                                                          Text(controller
                                                              .posts[index]
                                                              .location!),
                                                        ],
                                                      ),
                                                    ),
                                                    (controller.uid !=
                                                            controller
                                                                .posts[index]
                                                                .ownderId)
                                                        ? ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Color(
                                                                            0xFF2C5364))),
                                                            onPressed:
                                                                () async {
                                                              String email = Uri
                                                                  .encodeComponent(
                                                                      controller
                                                                          .posts[
                                                                              index]
                                                                          .email!);
                                                              String subject = Uri
                                                                  .encodeComponent(
                                                                      "Hello Flutter");
                                                              String body = Uri
                                                                  .encodeComponent(
                                                                      "Hi! I'm Flutter Developer");
                                                              print(
                                                                  subject); //output: Hello%20Flutter
                                                              Uri mail = Uri.parse(
                                                                  "mailto:$email?subject=$subject&body=$body");
                                                              if (await launchUrl(
                                                                  mail)) {
                                                                //email app opened
                                                              } else {
                                                                //email app is not opened
                                                              }
                                                            },
                                                            child:
                                                                Text("Send CV"))
                                                        : Text("")
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ))
          ],
        ),
      ),
    ));
  }
}
