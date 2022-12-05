import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/Post/postController.dart';
import 'package:rescue_pet/model/User/UserController.dart';

import '../details/details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PostController postController = Get.find();
  UserController userController = Get.find();
  List _posts = [];
  List _foundPosts = [];

  @override
  void initState() {
    print(postController.posts);
    setState(() {
      _posts = postController.posts;
    });
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List _results = [];
    setState(() {
      _foundPosts = [];
    });
    if (enteredKeyword.isEmpty) {
      _results = _posts;
    } else {
      for (var post in _posts) {
        // print(post[0][0]);
        if (post.location
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          _results.add(post);
        }
      }
    }
    setState(() {
      _foundPosts = _results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: 'Search by location',
                  prefixIcon: Icon(Icons.search),
                  label: Text('Search')),
              onChanged: (value) {
                _runFilter(value);
              },
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _foundPosts.isNotEmpty ? _foundPosts.length : 1,
                itemBuilder: (BuildContext context, index) {
                  return _foundPosts.isEmpty
                      ? const ListTile(
                          title: Text('Not Found'),
                          leading: Icon(Icons.pets_rounded),
                        )
                      : ListTile(
                          title: Text(_foundPosts[index].location),
                          leading: Image.network(
                            _foundPosts[index].imgUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(_foundPosts[index].uid)));
                    },
                        );
                })
          ],
        ),
      ),
    ));
  }
}
