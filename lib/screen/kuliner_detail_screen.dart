import 'package:flutter/material.dart';

class KulinerDetailScreen extends StatefulWidget {
  const KulinerDetailScreen({super.key});

  @override
  State<KulinerDetailScreen> createState() => _KulinerDetailScreenState();
}

class _KulinerDetailScreenState extends State<KulinerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kuliner"),
      ),
      body: Column(),
    );
  }
}