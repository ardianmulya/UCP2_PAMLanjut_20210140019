import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ucp2_pam/controller/kuliner_controller.dart';
import 'package:ucp2_pam/model/kuliner.dart';
import 'package:ucp2_pam/screen/kuliner_screen.dart';
import 'package:ucp2_pam/screen/maps_screen.dart';

class FormKulinerScreen extends StatefulWidget {
  const FormKulinerScreen({super.key});

  @override
  State<FormKulinerScreen> createState() => _FormKulinerScreenState();
}

class _FormKulinerScreenState extends State<FormKulinerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

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
                    controller: _namaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Kuliner tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Kuliner',
                      labelText: 'Nama Kuliner',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                              width: double.infinity,
                              child: Text('Lokasi'),
                            ),
                      _alamat == null
                          ? const SizedBox(
                              width: double.infinity,
                              child: Text('Lokasi'),
                            )
                          : Text('$_alamat'),
                      _alamat == null
                          ? TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapsScreen(
                                      onLocationSelected: (selectedAddress) {
                                        setState(() {
                                          _alamat = selectedAddress;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Pilih Lokasi"))
                          : TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapsScreen(
                                      onLocationSelected: (selectedAddress) {
                                        setState(() {
                                          _alamat = selectedAddress;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Ubah Alamat'))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextFormField(
                    controller: _deskripsiController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Deskripsi Kuliner Seperti Harga/Rasa',
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
                              lokasi: _alamat ?? '',
                              deskripsi: _deskripsiController.text,
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KulinerScreen(),
                            ),
                            (route) => false);
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
