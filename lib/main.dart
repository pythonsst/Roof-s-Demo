import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:roof/features/bloc.dart';
import 'package:roof/features/repo/user_repo.dart';

import 'features/model/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<PhotoBloc>(
      builder: (context) => PhotoBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users;
  List<int> maxUsers = [];

  @override
  void initState() {
    super.initState();

    maxUsers.addAll(List.generate(100, (x) => x));
    users = [];
  }

  bool onNotification(ScrollNotification scrollInfo, PhotoBloc bloc) {
    // print(scrollInfo);
    if (scrollInfo is OverscrollNotification) {
      bloc.sink.add(scrollInfo);
    }
    return false;
  }

  Widget buildListView(
    BuildContext context,
    AsyncSnapshot<List<User>> snapshot,
  ) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    users.addAll(snapshot.data);

    return ListView.builder(
      itemCount: (maxUsers.length > users.length)
          ? users.length + 1
          : users.length,
      itemBuilder: (context, index) => (index == users.length)
          ? Container(
              margin: EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListTile(
              leading:
                  CircleAvatar(child: Text(users[index].userId.toString())),
              title: Text(users[index].id.toString()),
              subtitle: Text(users[index].title),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PhotoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Roof App")),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) => onNotification(notification, bloc),
        child: StreamBuilder<List<User>>(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            return buildListView(context, snapshot);
          },
        ),
      ),
    );
  }
}
