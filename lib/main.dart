import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> aktiviteter = [
    {"aktivitet": "Städa", "checked": false},
    {"aktivitet": "Tvätta", "checked": false},
    {"aktivitet": "Laga mat", "checked": false},
    {"aktivitet": "Träna", "checked": false},
  ];
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Att göra'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_vert),
                tooltip: "Alternativ",
                onPressed: () {
                  setState(() {
                    // gör något
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
                children: aktiviteter.map((a) {
              return CheckboxListTile(
                  value: a["checked"],
                  title: Text(a["aktivitet"]),
                  secondary: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red[300],
                    tooltip: "Delete",
                    onPressed: () {
                      setState(() {
                        // gör något
                      });
                    },
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                  onChanged: (newvalue) {
                    setState(() {
                      a["checked"] = newvalue;
                    });
                  });
            }).toList()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                // gör något
              });
            },
            tooltip: "Lägg till",
            child: const Icon(Icons.add),
            //backgroundColor: Colors.green,
          ));
    });
  }
}
