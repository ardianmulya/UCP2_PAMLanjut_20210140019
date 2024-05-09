import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
    final Function(String) onLocationSelected;
  const MapsScreen({super.key, required this.onLocationSelected});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}