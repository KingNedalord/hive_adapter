import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'oquvchi.dart';

late Box box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OquvchiAdapter());
  box = await Hive.openBox("oquvchi");
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ocupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive adapter"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Age"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ocupationController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Ocupation"),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Oquvchi oquvchi = Oquvchi(
                  name: nameController.text,
                  age: ageController.text,
                  ocupation: ocupationController.text);
              box.add(oquvchi);
            },
            child: Text("Save"),
            color: Colors.blue,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.blue,
                          margin: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(box.getAt(index).name),
                              Text(box.getAt(index).age),
                              Text(box.getAt(index).ocupation),
                            ],
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
