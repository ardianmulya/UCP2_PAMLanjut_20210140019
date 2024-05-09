import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucp2_pam/controller/kuliner_controller.dart';
import 'package:ucp2_pam/model/kuliner.dart';
import 'package:ucp2_pam/screen/edit_kuliner_screen.dart';
import 'package:ucp2_pam/screen/form_kuliner_screen.dart';
import 'package:ucp2_pam/screen/kuliner_detail_screen.dart';

class KulinerScreen extends StatefulWidget {
  const KulinerScreen({super.key});

  @override
  State<KulinerScreen> createState() => _KulinerScreenState();
}

class _KulinerScreenState extends State<KulinerScreen> {
  final KulinerController _controller = KulinerController();

  @override
  void initState() {
    super.initState();
    _controller.getKuliner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Kuliner"),
        ),
        body: FutureBuilder<List<Kuliner>>(
          future: _controller.getKuliner(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Kuliner kuliner = snapshot.data![index];
                  return Container(
                    height: 150,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      KulinerDetailScreen(kuliner: kuliner),
                                ),
                              );
                            },
                            title: Text(kuliner.nama),
                            subtitle: Text(kuliner.lokasi),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(kuliner.foto),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 85)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditKulinerScreen(kuliner: kuliner),
                                ),
                              );
                                },
                                child: Icon(Icons.edit),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FormKulinerScreen()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
