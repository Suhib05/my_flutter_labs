import 'package:flutter/material.dart';
import 'shopping_item.dart';
import 'shopping_dao.dart';
import 'app_database.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() =>
      _ShoppingListPageState();
}

class _ShoppingListPageState
    extends State<ShoppingListPage> {

  // Controllers
  final TextEditingController itemController =
  TextEditingController();

  final TextEditingController quantityController =
  TextEditingController();

  // List now holds ShoppingItem objects loaded from / saved to the DB
  List<ShoppingItem> items = [];

  late ShoppingDao shoppingDao;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final database =
    await $FloorAppDatabase.databaseBuilder('shopping.db').build();
    shoppingDao = database.shoppingDao;

    // Requirement 2: load saved items on restart
    shoppingDao.findAllItems().then((list) {
      setState(() {
        items = list;
      });
    });
  }

  @override
  void dispose() {
    itemController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  // Add item
  void addItem() {

    if (itemController.text.trim().isEmpty ||
        quantityController.text.trim().isEmpty) {
      return;
    }

    final newItem = ShoppingItem(
      name: itemController.text.trim(),
      quantity: quantityController.text.trim(),
    );

    // Requirement 1: insert into DB when Add is pressed
    shoppingDao.insertItem(newItem).then((_) {
      shoppingDao.findAllItems().then((list) {
        setState(() {
          items = list;
          itemController.clear();
          quantityController.clear();
        });
      });
    });
  }

  // Delete dialog
  void showDeleteDialog(int index) {

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text("Delete Item"),

          content: Text(
              "Delete ${items[index].name}?"),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);
              },

              child: const Text("No"),
            ),

            TextButton(

              onPressed: () {

                final itemToDelete = items[index];

                // Requirement 3: delete from database
                shoppingDao.deleteItem(itemToDelete).then((_) {
                  setState(() {
                    items.removeAt(index);
                  });
                });

                Navigator.pop(context);

              },

              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  // ListView
  Widget ListPage() {

    if (items.isEmpty) {

      return const Center(
        child: Text(
          "There are no items in the list",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(

      itemCount: items.length,

      itemBuilder: (context, index) {

        return Card(

          margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5),

          child: ListTile(

            title: Text(
                "${index + 1}. ${items[index].name}"),

            trailing:
            Text(items[index].quantity),

            onLongPress: () {

              showDeleteDialog(index);

            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
            "Shopping List"),

      ),

      body: Padding(

        padding:
        const EdgeInsets.all(10),

        child: Column(

          children: [

            TextField(

              controller: itemController,

              decoration:
              const InputDecoration(

                labelText: "Item",

                border:
                OutlineInputBorder(),

              ),
            ),

            const SizedBox(height: 10),

            TextField(

              controller:
              quantityController,

              keyboardType:
              TextInputType.number,

              decoration:
              const InputDecoration(

                labelText: "Quantity",

                border:
                OutlineInputBorder(),

              ),
            ),

            const SizedBox(height: 10),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: addItem,

                child:
                const Text("Add"),

              ),
            ),

            const SizedBox(height: 10),

            Expanded(

              child: ListPage(),

            ),
          ],
        ),
      ),
    );
  }
}