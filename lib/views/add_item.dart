import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/items_provider.dart';
import 'package:provider/provider.dart';

class AddItem extends StatelessWidget {
  final _controller = TextEditingController();
  bool checkAll = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Lägg till att göra'),
            centerTitle: true,
          ),
          body: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 300),
                child: TextFormField(
                  onFieldSubmitted: (value) async {
                    Provider.of<ItemsProvider>(context, listen: false)
                        .addItem(_controller.text, false);
                    Navigator.pop(context);
                  },
                  decoration: InputDecoration(
                    suffix: IconButton(
                      onPressed: _controller.clear,
                      icon: const Icon(Icons.clear),
                    ),
                    border: const UnderlineInputBorder(),
                    hintText: "Lägg till aktivitet",
                  ),
                  controller: _controller,
                ),
              ),
            ],
          ));
    });
  }
}
