// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/urun.dart';
import 'package:intl/intl.dart';

import '../utils/databaseHelper.dart';

class Guncelle extends StatefulWidget {
  const Guncelle({super.key});

  @override
  State<Guncelle> createState() => _GuncelleState();
}

class _GuncelleState extends State<Guncelle> {
  final DbHelper = DatabaseHelper.instance;
  final TextEditingController _GuncelleurunIdcontroller = TextEditingController();
  final TextEditingController _GuncelleurunAdicontroller = TextEditingController();
  final TextEditingController _GuncelleurunMarkasicontroller = TextEditingController();
  final TextEditingController _GuncelleurunFiyaticontroller = TextEditingController();
  final TextEditingController _GuncelleurunStokcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {},
                controller: _GuncelleurunIdcontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'id'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _GuncelleurunAdicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'ürün adı'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _GuncelleurunMarkasicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'markası'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _GuncelleurunFiyaticontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'fiyat'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _GuncelleurunStokcontroller,
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
                  int urunId = int.parse(_GuncelleurunIdcontroller.text);
                  String urunAdi = _GuncelleurunAdicontroller.text;
                  String urunMarkasi = _GuncelleurunMarkasicontroller.text;
                  int urunFiyati =
                      int.parse(_GuncelleurunFiyaticontroller.text);
                  int urunStok = int.parse(_GuncelleurunStokcontroller.text);
                  DateTime now = DateTime.now();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);
                  String olusturulmaTarihi = formattedDate;
                  Urun GuncellenecekUrun = Urun(urunId, urunAdi, urunMarkasi,
                      urunFiyati, urunStok, olusturulmaTarihi);
                  _update(GuncellenecekUrun);
                },
                child: const Text("Güncelle"))
          ],
        ),
      ),
    );
  }

  void _update(Urun GuncellenecekUrun) {
    DbHelper.update(GuncellenecekUrun);
    debugPrint("güncelleme basarılı ");
  }
}
