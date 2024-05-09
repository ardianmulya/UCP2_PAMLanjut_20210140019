import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ucp2_pam/controller/kuliner_controller.dart';
import 'package:ucp2_pam/model/kuliner.dart';

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

    Future<void> getImage() async {
    final XFile? pickedFile =
      await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No image selected");
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Kuliner'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Makanan tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Makanan',
                      labelText: 'Nama Makanan',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lokasi tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Lokasi',
                      labelText: 'Lokasi',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Deskripsi Makanan',
                      labelText: 'Deskripsi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _image == null
                    ? const Text("Belum ada gambar yang dipilih")
                    : Container(
                        height: 250,
                        margin: const EdgeInsets.all(20),
                        child: Image.file(_image!),
                      ),
                ElevatedButton(
                  onPressed: getImage,
                  child: const Text("Pilih Gambar"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await KulinerController().addKuliner(
                          Kuliner(
                              nama: _namaController.text,
                              lokasi: _lokasiController.text,
                              deskripsi:_deskripsiController.text,
                              foto: _image!.path),
                          _image,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['message'],
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}