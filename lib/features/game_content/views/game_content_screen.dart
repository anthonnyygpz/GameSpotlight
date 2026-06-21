import 'package:flutter/material.dart';

class GameContentScreen extends StatelessWidget {
  final String? id;

  const GameContentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('GameContentScreen $id')));
  }
}
