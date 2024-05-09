import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormKulinerScreen extends StatefulWidget {
  const FormKulinerScreen({super.key});

  @override
  State<FormKulinerScreen> createState() => _FormKulinerScreenState();
}

class _FormKulinerScreenState extends State<FormKulinerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _deskripsiController = TextEditingController();

    File? _image;
  final _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}