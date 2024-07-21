import 'package:banner_carousel/banner_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restauran_menu/models/makanan_model.dart';
import 'package:restauran_menu/resource/resource.dart';
import 'package:restauran_menu/ui/detailProduct.dart';
import 'package:restauran_menu/widget/banner.dart';
import 'package:restauran_menu/widget/card_vertical.dart';
import 'package:restauran_menu/widget/popup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> kategori = ["All Dishes", "Most Popular", "Salad", "Avocado"];
  int isActive = 0;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('kategori').snapshots();

  final namaMakanan = TextEditingController();
  final harga = TextEditingController();
  final rating = TextEditingController();
  final image = TextEditingController();
  final deskripsi = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future add() async {
    try {
      final makanan = FirebaseFirestore.instance.collection('makanan');
      await makanan.add(MakananModel(
              nama: namaMakanan.text,
              harga: double.parse(harga.text),
              rating: int.parse(rating.text),
              image: image.text,
              deskripsi: deskripsi.text)
          .toMap());
      await const Popup(popupType: PopupType.success).show(context);
    } catch (e) {
      await const Popup(popupType: PopupType.error).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
              size: 19,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Gram Bistro",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.format_align_left),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Choose the best dish for you",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Search button
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            hintText: 'Search',
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.filter_list_outlined,
                                color: Colors.amber[700]),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Carousel slider
                  BannerCarousel.fullScreen(
                    pageController: PageController(initialPage: 1),
                    height: 150,
                    activeColor: Colors.amberAccent,
                    disableColor: Colors.white,
                    animation: true,
                    // customizedIndicators: IndicatorModel.animation(
                    //     width: 10, height: 10, spaceBetween: 2, widthAnimation: 2),
                    initialPage: 1,
                    onTap: (index) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detailproduct(),
                          ));
                    },
                    borderRadius: 10,
                    indicatorBottom: false,
                    viewportFraction: 0.60,
                    showIndicator: false,
                    customizedBanners: [
                      Banners(
                        image: ayam,
                        subtitle: "Product of the day",
                        title: "Avocado Chicken \nSalad",
                        price: "10.40",
                      ),
                      Banners(
                        image: nasgor,
                        subtitle: "Product of the day",
                        title: "Fried rice betawi",
                        price: "5.00",
                      ),
                      Banners(
                        image: paket1,
                        subtitle: "Product of the day",
                        title: "Paket Ayam \nCabe Garam",
                        price: "11.01",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Kategori
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _usersStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) => FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      isActive = index;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        (isActive == index)
                                            ? Colors.amber[700]
                                            : Colors.transparent),
                                  ),
                                  child: Text(
                                      snapshot.data!.docs[index]
                                          ["nama_kategori"],
                                      style: TextStyle(
                                          color: isActive == index
                                              ? Colors.white
                                              : Colors.grey)),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Products
                  const Text(
                    "Most Popular",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  // Read data from firestore
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('makanan')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data!.docs.map((e) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detailproduct(
                                        id: e.id,
                                        image: e['image'],
                                        title: e['namaMakanan'],
                                        harga: e['harga'],
                                        rating: e['rating'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Productsv(
                                  image: e['image'],
                                  title: e['namaMakanan'],
                                  price: e['harga'].toString(),
                                  review: e['rating'].toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Recommended",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('makanan')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data!.docs
                                .map((data) => Productsv(
                                      image: data['image'],
                                      title: data['namaMakanan'],
                                      price: data['harga'].toString(),
                                      review: data['rating'].toString(),
                                    ))
                                .toList(),
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            // Tambah data produk
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: 550,
                              width: double.infinity,
                              color: Colors.grey[100],
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Tambah Makanan 🍽️",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // form makanan
                                    child: Form(
                                        key: _formkey,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            // Nama makanan
                                            TextFormField(
                                              controller: namaMakanan,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'masukan nama makanan';
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                label: const Text(
                                                  "nama makanan",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                filled: true,
                                                hoverColor: Colors.black,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(13),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            // Harga
                                            TextFormField(
                                              controller: harga,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'masukan nama harga';
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                label: const Text(
                                                  "masukan harga",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                filled: true,
                                                hoverColor: Colors.black,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(13),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                            // deskripsi
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: deskripsi,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'masukan deskripsi';
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                label: const Text(
                                                  "masukan Deskripsi",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                filled: true,
                                                hoverColor: Colors.black,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(13),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                            // Rating
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: rating,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'masukan rating';
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                label: const Text(
                                                  "masukkan Rating",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                filled: true,
                                                hoverColor: Colors.black,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(13),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                            // image
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: image,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                label: const Text(
                                                  "Upload image online (https://...)",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                filled: true,
                                                hoverColor: Colors.black,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(13),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            // button tambah data
                                            SizedBox(
                                              width: double.infinity,
                                              height: 50,
                                              child: FilledButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.orange)),
                                                onPressed: () async {
                                                  await add();
                                                  namaMakanan.clear();
                                                  harga.clear();
                                                  rating.clear();
                                                  image.clear();
                                                  deskripsi.clear();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Tambah data",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
