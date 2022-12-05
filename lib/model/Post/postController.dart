import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/Post/post.dart';

class PostController extends GetxController {
  List posts = [].obs;

  getAllPosts() async {
    posts.clear();
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      //   for (int i = 0; i < value.docs.length; i++) {
      //     posts.add([
      //       value.docs[i].get('location'),
      //       value.docs[i].get('breed'),
      //       value.docs[i].get('reason'),
      //       value.docs[i].get('imgUrl')
      //     ]);
      //   }
      // });
      for (int i = 0; i < value.docs.length; i++) {
        posts.add(PostModel(
            value.docs[i].id,
            value.docs[i].get('location'),
            value.docs[i].get('breed'),
            value.docs[i].get('reason'),
            value.docs[i].get('imgUrl'),
            value.docs[i].get('postBy'),
            value.docs[i].get('contact')));
      }
    });
    print(posts);
  }
}
