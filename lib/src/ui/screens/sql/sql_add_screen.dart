import 'package:demo_branching/src/blocs/blocs.dart';
import 'package:demo_branching/src/repositories/repositories.dart';
import 'package:flutter/material.dart';

class SqlAddScreen extends StatelessWidget {
  const SqlAddScreen({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final void Function(SqlEvent) onAdd;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('SQL Add'),
          actions: [
            IconButton(
              onPressed: () {
                onAdd(
                  SqlAddEvent(
                    dog: Dog(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
          ],
        ));
  }
}
