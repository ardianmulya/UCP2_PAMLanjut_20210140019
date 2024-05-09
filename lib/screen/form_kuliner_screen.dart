import 'package:flutter/material.dart';
import 'package:ucp2_pam/controller/kuliner_controller.dart';
import 'package:ucp2_pam/model/kuliner.dart';

class FormKulinerScreen extends StatefulWidget {
  const FormKulinerScreen({super.key});

  @override
  State<FormKulinerScreen> createState() => _FormKulinerScreenState();
}

class _FormKulinerScreenState extends State<FormKulinerScreen> {
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
                  return ListTile(
                    onTap: (){},
                    title: Text(kuliner.nama),
                    subtitle: Text(kuliner.lokasi),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(kuliner.foto),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FormKulinerScreen()));
          },
          child: const Icon(Icons.add),
        )
    );
  }
}
