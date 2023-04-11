import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/urun.dart';
import 'package:intl/intl.dart';

import '../utils/databaseHelper.dart';

class Ekle extends StatefulWidget {
  const Ekle({super.key});

  @override
  State<Ekle> createState() => _EkleState();
}

class _EkleState extends State<Ekle> {
  final DbHelper = DatabaseHelper.instance;
  TextEditingController _urunAdicontroller = TextEditingController();
  TextEditingController _urunMarkasicontroller = TextEditingController();
  TextEditingController _urunFiyaticontroller = TextEditingController();
  TextEditingController _urunStokcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _urunAdicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'ürün adı'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _urunMarkasicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'markası'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _urunFiyaticontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'fiyat'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _urunStokcontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'stok'),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  String urunAdi = _urunAdicontroller.text;
                  String urunMarkasi = _urunMarkasicontroller.text;
                  int urunFiyati = int.parse(_urunFiyaticontroller.text);
                  int urunStok = int.parse(_urunStokcontroller.text);
                  _insert(urunAdi, urunMarkasi, urunFiyati, urunStok);
                  print("kayıt basarılı ");
                },
                child: const Text("kaydet"))
          ],
        ),
      ),
    );
  }

  void _insert(
      String urunAdi, String urunMarkasi, int urunFiyati, int urunStok) async {
         DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    Map<String, dynamic> row = {
      
      
      DatabaseHelper.columnurunAdi: urunAdi,
      DatabaseHelper.columnurunMarkasi: urunMarkasi,
      DatabaseHelper.columnurunFiyati: urunFiyati,
      DatabaseHelper.columnurunStok: urunStok,
      DatabaseHelper.columnolusturulmaTarihi : formattedDate 
    };
    Urun urun = Urun.fromMap(row);
    final id = await DbHelper.insert(urun);
  }
}
