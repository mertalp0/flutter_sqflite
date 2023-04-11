class Urun {
  int? id;
  String? urunAdi;
  String? urunMarkasi;
  int? urunFiyati;
  int? urunStok;
  String? olusturulmaTarihi;

  Urun(this.id, this.urunAdi, this.urunMarkasi, this.urunFiyati, this.urunStok,
      this.olusturulmaTarihi);

  Urun.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    urunAdi = map['urunAdi'];
    urunMarkasi = map['urunMarkasi'];
    urunFiyati = map['urunFiyati'];
    urunStok = map['urunStok'];
    olusturulmaTarihi = map['olusturulmaTarihi'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urunAdi': urunAdi,
      'urunMarkasi': urunMarkasi,
      'urunFiyati': urunFiyati,
      'urunStok': urunStok,
      'olusturulmaTarihi': olusturulmaTarihi,
    };
  }
}
