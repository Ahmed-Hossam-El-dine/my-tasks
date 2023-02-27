import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final _items = [];

  ////The key of the list////
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  ////Add a new item to the list////
  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }

  ////Remove an item////
  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.red,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("Deleted", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
      
    }, duration: const Duration(seconds: 1));

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('Animated List'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 15,
          ),
          IconButton(
            color: Colors.white,
            hoverColor: Colors.black,
            icon: const Icon(Icons.add),
            onPressed: () {
              _addItem();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ////Animated List////
          AnimatedList(
            shrinkWrap: true,
            key: _key,
            initialItemCount: 0,
            padding: const EdgeInsets.all(10),
            itemBuilder: (_, index, animation) {
              return SizeTransition(
                key: UniqueKey(),
                sizeFactor: animation,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  shape: const StadiumBorder(
                      side: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  )),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(_items[index],
                        style: const TextStyle(fontSize: 24)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
