import 'package:flutter/material.dart';
import 'package:ucp2_pam/controller/kuliner_controller.dart';
import 'package:ucp2_pam/model/kuliner.dart';
import 'package:ucp2_pam/screen/edit_kuliner_screen.dart';

class KulinerDetailScreen extends StatelessWidget {
  final Kuliner kuliner;
  const KulinerDetailScreen({
    super.key,
    required this.kuliner,
  });

  @override
  Widget build(BuildContext context) {
    final kulinerController = KulinerController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kuliner"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(kuliner.foto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Nama Kuliner : " + kuliner.nama,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Lokasi : " + kuliner.lokasi,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Deskripsi : " + kuliner.deskripsi,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditKulinerScreen(),
                        ),
                      );
                    },
                    child: Text("Edit")),
                ElevatedButton(
                    onPressed: () async{
                      var result = await kulinerController.deleteKuliner(kuliner.id.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result.body,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Hapus"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
