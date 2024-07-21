import 'package:flutter/material.dart';
import 'package:restauran_menu/resource/resource.dart';
import 'package:restauran_menu/widget/card.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  List<String> kategori = ["Eat", "Drink", "Dessert"];
  int isActive = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(247, 247, 247, 247),
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(247, 247, 247, 247),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "We think you might enjoy these \nSpecially selected dishes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kategori.length,
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
                      child: Text(kategori[index],
                          style: TextStyle(
                              color: isActive == index
                                  ? Colors.white
                                  : Colors.grey)),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.dashboard_outlined,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Product(
                      title: "Avocado and Egg Toast",
                      image: ayam,
                      price: "10.40",
                      review: "4.5",
                      jmlview: "(20 reviews)",
                    ),
                    Product(
                      title: "Mac and Cheese",
                      image: ayamBakar,
                      price: "12.99",
                      review: "4.5",
                      jmlview: "(20 reviews)",
                    ),
                    Product(
                      title: "Power bowl",
                      image: nasgor,
                      price: "11.99",
                      review: "4.5",
                      jmlview: "(20 reviews)",
                    ),
                    Product(
                      title: "Vegetable salad",
                      image: paket1,
                      price: "9.99",
                      review: "4.5",
                      jmlview: "(20 reviews)",
                    ),
                    Product(
                      title: "Vegetable salad",
                      image: paket1,
                      price: "9.99",
                      review: "4.5",
                      jmlview: "(20 reviews)",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
