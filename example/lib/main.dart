import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:memoji/memoji.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String? _imagePath;
  String _key = "initial";

  Future<void> _getMemoji() async {
    try {
      String? newPath = await Memoji.getMemojiAndSave();
      if (newPath == null) {
        debugPrint('Memoji is null.');
        return;
      }

      debugPrint('Memoji saved to $newPath');

      setState(() {
        _key = DateTime.now().millisecondsSinceEpoch.toString();
        _imagePath = newPath;
      });
    } on PlatformException {
      debugPrint('Failed to get memoji.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memoji Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              key: ValueKey(_key),
              radius: 100,
              backgroundColor: Colors.grey[200],
              backgroundImage: _imagePath != null
                  ? FileImage(
                      File(
                        _imagePath!,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getMemoji,
              child: const Text('Get Memoji'),
            ),
          ],
        ),
      ),
    );
  }
}
