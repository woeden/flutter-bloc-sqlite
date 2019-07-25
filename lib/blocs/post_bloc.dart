import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test_bloc/models/post.dart';
import 'package:test_bloc/providers/post_provider.dart';

import '../db.dart';
import '../repository.dart';

class PostsBloc {
  List<Post> posts;
  Database db;

  postBloc() {
  }


  final _postFetcher = PublishSubject<List<Post>>();
  final provider = new PostsProvider();

  Observable<List<Post>> get allMovies => _postFetcher.stream;

  fetchAllMovies() async {
    db = await DBProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query('post');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    List<Post> posts = List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        userId: maps[i]['userId'],
      );
    });

    _postFetcher.sink.add(posts);
  }

  deletePost({id}) {
    posts.removeWhere((post) => post.id == id);
    _postFetcher.sink.add(posts);
  }

  testDB() async {
    Post post = new Post(userId: 7, title: "Ce titre", body: "Lorem ipsum");
    print(post.toMap());
    var res = await db.insert("post",
        post.toMap(id:null));

    posts.add(post);
    _postFetcher.sink.add(posts);

  }

  dispose() {
    _postFetcher.close();
  }
}

final bloc = PostsBloc();
