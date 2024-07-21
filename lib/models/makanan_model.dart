class MakananModel {
  MakananModel(
      {this.nama, this.harga, this.rating, this.image, this.deskripsi});
  final String? nama;
  final double? harga;
  final int? rating;
  final String? image;
  final String? deskripsi;
  factory MakananModel.fromMap(Map<String, dynamic> data) {
    return MakananModel(
      nama: data['namaMakanan'],
      harga: data['harga'],
      rating: data['rating'],
      image: data['image'],
      deskripsi: data['deskripsi'],
    );
  }
  Map<String, dynamic> toMap() => {
        "namaMakanan": nama,
        "harga": harga,
        "rating": rating,
        "image": image,
        "deskripsi": deskripsi
      };
}
