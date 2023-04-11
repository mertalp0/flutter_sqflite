import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/urun.dart';

import '../utils/databaseHelper.dart';

class Listele extends StatefulWidget {
  const Listele({super.key});

  @override
  State<Listele> createState() => _ListeleState();
}

class _ListeleState extends State<Listele> {
  late int id ; 
  final DbHelper = DatabaseHelper.instance;
  List<Urun> urunler = [];
  @override
  void initState() {
    _queryAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: urunler.isEmpty
          ? const Center(child: Text("veri yok"))
          : Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.48,
                ),
                itemCount: urunler.length,
                itemBuilder: (BuildContext context, int index) {
                id = urunler[index].id!;
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(3)),
                          width: MediaQuery.of(context).size.width,
                          child: const Center(child: Text("image")),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 2),
                          child: Text(
                            urunler[index].urunMarkasi.toString().toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 1),
                          child: Text(
                            urunler[index].urunAdi.toString(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 1),
                          child: Text(
                            " ${urunler[index].urunFiyati.toString()} TL",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 1),
                          child: Text(
                              "Stok : ${urunler[index].urunStok.toString()}",
                              style: const TextStyle(fontSize: 11)),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kod : ${urunler[index].id.toString()}",
                                  style: const TextStyle(fontSize: 11)),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return sildialog();
                                    },
                                  ).then((value) {
                                    if (value != null && value) {
                                    _delete(id, index);
                                    }
                                  });
                                },
                                child: const Text("Sil",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
    );
  }

  void _queryAll() async {
    debugPrint("object");
    final allRows = await DbHelper.queryAllRows();
    urunler.clear();
    for (var row in allRows) {
      urunler.add(Urun.fromMap(row));
    }
    debugPrint("liste gosterildi");
    debugPrint(urunler.length.toString());
    setState(() {});
  }

  Future<void> _delete(int id, int index) async {
    debugPrint("silindi $id");
    final rowsDeleted = await DbHelper.delete(id);
    urunler.removeAt(index);
    setState(() {});
  }

  Widget sildialog() {
    return AlertDialog(
      title: const Text('Emin misiniz?'),
      content: const Text('Bu ürünü silmek istediğinize emin misiniz?'),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(false); // İptal etmek için false değeri döndürür
          },
          child: const Text('İptal'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(true); // Silmeyi onaylamak için true değeri döndürür
          },
          child: const Text('Sil'),
        ),
      ],
    );
  }
}
