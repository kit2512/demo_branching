import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Features"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              // TODO: handle Image Capture
            },
            child: const Text("Capture Image"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Handle Google Maps
            },
            child: const Text("Capture Image"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Handle Gallery Image
            },
            child: const Text("Gallery Image"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Handle Sqlite
            },
            child: const Text("SQL"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: handle Firebase authentication
            },
            child: const Text("Firebase Authentication"),
          )
        ]),
      ),
    );
  }
}
