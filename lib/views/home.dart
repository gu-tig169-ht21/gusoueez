import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/items.dart';
import 'package:my_first_app/models/items_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final _controller = TextEditingController();
  bool checkAll = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
          appBar: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return Checkbox(
                  value: checkAll,
                  activeColor: Colors.green,
                  onChanged: (newValue) {
                    setState(() {
                      checkAll = newValue!;
                      Provider.of<ItemsProvider>(context, listen: false)
                          .updateAll(newValue);
                    });
                  });
            }),
            title: const Text('Att göra'),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) {
                  setState(() {
                    Provider.of<ItemsProvider>(context, listen: false)
                        .setFilterBy(value);
                  });
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(child: Text('Visa alla'), value: 'alla'),
                  const PopupMenuItem(
                      child: Text('Visa avklarade'), value: 'markerad'),
                  const PopupMenuItem(
                      child: Text('Visa inte avklarade'),
                      value: 'inte markerad')
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<ItemsProvider>(
                builder: (context, ItemsProvider data, child) {
              return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: _filterList(data.getAktiviteter, data.filterBy)!
                      .map((card) => ListItem(context, card))
                      .toList());
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

Widget deleteButton(BuildContext context, item, String aktivitet) {
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
                  .removeItem(item);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}

class ListItem extends StatelessWidget {
  final Items item;
  BuildContext context;
  ListItem(this.context, this.item);
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
          padding: const EdgeInsets.all(2),
          child: CheckboxListTile(
              value: item.checked,
              title: Text(item.aktivitet),
              secondary: deleteButton(context, item, item.aktivitet),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
              onChanged: (newvalue) {
                setState(() {
                  item.checked = newvalue!;
                });
              }));
    });
  }
}

List<Items>? _filterList(List<Items> list, filterBy) {
  if (filterBy == 'alla') return list;
  if (filterBy == 'markerad') {
    return list.where((item) => item.checked == true).toList();
  }
  if (filterBy == 'inte markerad') {
    return list.where((item) => item.checked == false).toList();
  }
  return list;
}
