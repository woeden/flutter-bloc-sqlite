import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/post.dart';

class PostsProvider {
  Client client = Client();

  Future<List<Post>> getPosts() async{
    List<Post> posts = [];
    final response = await client.get("https://jsonplaceholder.typicode.com/posts");
//    print(response.body.toString());

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      body.forEach((post){
        posts.add(Post.fromJson(post));
      });
      // If the call to the server was successful, parse the JSON
      return posts;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }


  }
}