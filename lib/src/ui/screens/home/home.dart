import 'package:demo_branching/src/ui/screens/screens.dart';
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaptureImageScreen(),
                ),
              );
            },
            child: const Text("Capture Image"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GalleryImageScreen(),
                ),
              );
            },
            child: const Text("Gallery Image"),
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
