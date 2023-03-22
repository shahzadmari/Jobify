import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/controllers/firestore_controller.dart';
import 'package:iec_project/models/user_model.dart';

class JobSeekers extends StatefulWidget {
  const JobSeekers({super.key});

  @override
  State<JobSeekers> createState() => _JobSeekersState();
}

class _JobSeekersState extends State<JobSeekers> {
  final TextEditingController _searchQueryController = TextEditingController();

  bool _isSearching = false;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        elevation: 0.0,
        titleSpacing: 0.0,
        leading: _isSearching ? const BackButton(color: Colors.black) : null,
        actions: _buildActions(),
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: GetBuilder<FirestoreController>(
            init: FirestoreController(),
            initState: (_) {},
            builder: (controller) {
              controller.getdata();

              return (controller.isLoading)
                  ? ListView.builder(
                      itemCount: controller.seekers.length,
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
                                          "${controller.seekers[index].url}")),
                                  Column(
                                    children: [
                                      Text(
                                        "${controller.seekers[index].name}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          "${controller.seekers[index].email}"),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${controller.seekers[index].experience}"),
                                          const Text(
                                            " | ",
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${controller.seekers[index].skills[0]}",
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
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ))
        ],
      ),
    ));
  }

  _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Row(
        children: const [
          Text(
            'Job',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' Seekers',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _buildSearchField() {
    return TextField(
      autofocus: true,
      cursorColor: Colors.blue,
      controller: _searchQueryController,
      decoration: const InputDecoration(
        hintText: "Search Jobs",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 20.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
