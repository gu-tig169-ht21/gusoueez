import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/items.dart';
import 'package:my_first_app/models/items_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Att göra'),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<bool>(
                onSelected: (value) {
                  setState(() {
                    Provider.of<ItemsProvider>(context, listen: false)
                        .updateAll(value);
                  });
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(child: Text('Markera alla'), value: true),
                  const PopupMenuItem(
                      child: Text('Avmarkera alla'), value: false)
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<ItemsProvider>(
                builder: (context, ItemsProvider data, child) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.getAktiviteter.length,
                itemBuilder: (context, index) {
                  return ItemList(data.getAktiviteter[index], index);
                },
              );
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _controller.clear();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 300),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
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
                  );
                },
              );
            },
            tooltip: "Lägg till",
            child: const Icon(Icons.add),
            //backgroundColor: Colors.green,
          ));
    });
  }
}

class ItemList extends StatelessWidget with ChangeNotifier {
  final Items items;
  int index;

  ItemList(this.items, this.index);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
          padding: const EdgeInsets.all(2),
          child: CheckboxListTile(
              value: items.checked,
              title: Text(
                items.aktivitet,
                style: (TextStyle(
                    decoration:
                        items.checked ? TextDecoration.lineThrough : null,
                    decorationThickness: 2)),
              ),
              secondary: deleteButton(context, index, items.aktivitet),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
              onChanged: (newvalue) {
                setState(() {
                  items.checked = newvalue!;
                });
              }));
    });
  }
}

Widget deleteButton(BuildContext context, index, String aktivitet) {
  return IconButton(
    icon: const Icon(Icons.delete_outline),
    color: Colors.red[300],
    tooltip: "Delete",
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Varning'),
        content: Text("Är du säker på att du vill radera '$aktivitet'?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Avbryt'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ItemsProvider>(context, listen: false)
                  .removeItem(index);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}
