import 'package:flutter/material.dart';
import 'package:my_first_app/models/items_provider.dart';
import 'package:my_first_app/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var ip = ItemsProvider();
    ip.getAktiviteter();
    return ChangeNotifierProvider(
        create: (context) => ip,
        child: MaterialApp(
            title: 'Att göra app',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Home()));
  }
}
