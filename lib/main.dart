import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice_flutter_isar/schema.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'isar_service.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isarInit();
  runApp(const MyApp());
}

Future<void> isarInit() async {
  isar = await Isar.open([
    TasksSchema,
    TodosSchema,
  ], directory: (await getApplicationSupportDirectory()).path);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '222'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service = IsarServices();
  var todoList = <Tasks>[];
  void addData() {
    //service.addTask('4', '4');

    service.addTodo(todoList[0], '2', '222', '9999', () => {});
  }

  @override
  void initState() {
    super.initState();
    getAll();
  }

  void getAll() async {
    List<Tasks> mData = await service.getAllTask();
    setState(() {
      todoList = mData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  addData();
                },
                child: const Text('添加')),
            Center(child: gridHeader(todoList))
          ],
        ),
      ),
    );
  }

  Widget gridHeader(List<Tasks> scenes) {
    return ListView.builder(
      itemCount: scenes.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Container(
            height: 38.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: Center(
                child: Text(
              '------------------  ${scenes[index].title}  ------------------',
              style: const TextStyle(
                  color: Colors.black26,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold),
            )),
          ),
          content: GridView.builder(
            padding: const EdgeInsets.all(20.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: scenes[index].todos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, itemIndex) {
              return Column(
                children: [
                  Container(
                      width: 66.0,
                      height: 66.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12, width: 0.8),
                          boxShadow: [
                            BoxShadow(color: Colors.black12.withOpacity(0.45))
                          ])),
                  const Padding(
                      padding: EdgeInsets.only(top: 12.0), child: Text("吃饭"))
                ],
              );
            },
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
