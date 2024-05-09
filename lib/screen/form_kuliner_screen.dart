import 'package:flutter/material.dart';
import 'package:ucp2_pam/controller/kuliner_controller.dart';

class FormKulinerScreen extends StatefulWidget {
  const FormKulinerScreen({super.key});

  @override
  State<FormKulinerScreen> createState() => _FormKulinerScreenState();
}

class _FormKulinerScreenState extends State<FormKulinerScreen> {
    final KulinerController _controller = KulinerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kuliner"),
      ),
      
    );
  }
}
