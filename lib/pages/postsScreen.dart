import 'package:flutter/material.dart';
import 'package:test_bloc/blocs/post_bloc.dart';
import 'package:test_bloc/models/post.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();

    return Scaffold(
      body: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
//                  separatorBuilder: (context, index) => Divider(
//                    color: Colors.blueGrey,
//                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data[index];
                    final key = Key(item.id.toString());
                    print(key != null);
                    return Dismissible(
                      key: key,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment(-1, 0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      secondaryBackground: Container(
                          color: Colors.green,
                          alignment: Alignment(1, 0),
                          padding: EdgeInsets.only(right: 50),
                          child: Icon(Icons.delete, color: Colors.white)),
                      onDismissed: (direction) {
                        bloc.deletePost(id: item.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.body),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          PostsBloc postsBloc = new PostsBloc();
          postsBloc.testDB();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
