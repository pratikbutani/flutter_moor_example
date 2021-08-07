import 'package:flutter/material.dart';
import 'package:flutter_moor_example/database/tables/category/categories_dao.dart';
import 'package:moor/moor.dart' as moor;

import './database/tables/todo/todo_dao.dart';
import 'database/moor_database.dart';

late MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: () => addRecords(), child: Text("Add Records")),
            Expanded(
              child: StreamBuilder<List<Todo>>(
                  stream: new TodoDao(database).watchAllTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Todo obj = snapshot.data![index];
                        return ListTile(
                          title: Text("Title ${obj.title}"),
                        );
                      },
                    );
                  }),
            )
          ],
        ));
  }

  addRecords() async {
    // CategoriesDao categoriesDao = new CategoriesDao(database);
    // await categoriesDao.bulkInsertTask([
    //   CategoriesCompanion(description: moor.Value("Flutter")),
    //   CategoriesCompanion(description: moor.Value("Android")),
    //   CategoriesCompanion(description: moor.Value("Java")),
    //   CategoriesCompanion(description: moor.Value("PHP")),
    //   CategoriesCompanion(description: moor.Value("OTHER")),
    // ]);

    TodoDao todoDao = new TodoDao(database);
    await todoDao.bulkInsertTask([
      TodosCompanion(
        title: moor.Value("Write Blog ${DateTime.now().microsecondsSinceEpoch}" ),
        category: moor.Value(1),
        content: moor.Value("Write blog about Moor Database"),
      ),
      // TodosCompanion(
      //   title: moor.Value("Write Blog"),
      //   category: moor.Value(1),
      //   content: moor.Value("Write blog about Moor Database"),
      // ),
      // TodosCompanion(
      //   title: moor.Value("Write Blog"),
      //   category: moor.Value(2),
      //   content: moor.Value("Write blog about Moor Database"),
      // ),
      // TodosCompanion(
      //   title: moor.Value("Write Blog"),
      //   category: moor.Value(2),
      //   content: moor.Value("Write blog about Moor Database"),
      // ),
      // TodosCompanion(
      //   title: moor.Value("Write Blog"),
      //   category: moor.Value(3),
      //   content: moor.Value("Write blog about Moor Database"),
      // ),
      // TodosCompanion(
      //   title: moor.Value("Write Blog"),
      //   category: moor.Value(4),
      //   content: moor.Value("Write blog about Moor Database"),
      // ),
    ]);

    print("Record Inserted in Database");

    // print("Total Records in Category : ${await categoriesDao.getTotalRecords()}");
    print("Total Records in TODO : ${await todoDao.getTotalRecords()}");
  }
}
