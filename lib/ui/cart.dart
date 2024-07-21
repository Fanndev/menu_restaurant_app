import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restauran_menu/resource/resource.dart';
import 'package:restauran_menu/ui/product.dart';
import 'package:restauran_menu/widget/popup.dart';
import 'package:restauran_menu/widget/product_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // State variable to track the active button index
  int? _activeIndex;

  // List of options
  final List<Map<String, dynamic>> _options = [
    {
      'icon': Icons.wallet,
      'text': 'Take away',
      'color': Colors.grey,
      'activeColor': Colors.orange,
    },
    {
      'icon': Icons.local_pizza,
      'text': 'Dine in',
      'color': Colors.grey,
      'activeColor': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  "Gram Bistro",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  "Your order",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('makanan')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> productList = snapshot.data!.docs.map((e) {
                        return ProductOnCart(
                          id: e.id,
                          image: e['image'],
                          title: e['namaMakanan'],
                          price: e['harga'].toDouble(), // Ensure it's a double
                          rating:
                              e['rating'].toDouble(), // Ensure it's a double
                        );
                      }).toList();
                      return Column(children: productList);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                // ProductOnCart(
                //   image: ayam,
                //   title: "Avocado and Egg \nToast",
                //   jmlview: "(20 reviews)",
                //   review: "5.0",
                //   price: "10.0",
                // ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.orange[300],
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Add more food to order",
                        style:
                            TextStyle(color: Colors.orange[300], fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black45, blurRadius: 5),
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: FilledButton(
                        onPressed: () {
                          // Modal sendorder
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: 240,
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    const Text(
                                      "Where do you want to have your dishes?",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children:
                                          _options.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        Map<String, dynamic> option =
                                            entry.value;

                                        return Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: _activeIndex == index
                                                ? FilledButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(option[
                                                                  'activeColor']),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _activeIndex = index;
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(option['icon'],
                                                            color:
                                                                Colors.white),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(option['text'],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                      ],
                                                    ),
                                                  )
                                                : OutlinedButton(
                                                    style: ButtonStyle(
                                                      side: WidgetStateProperty
                                                          .all(const BorderSide(
                                                              color:
                                                                  Colors.grey)),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _activeIndex = index;
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(option['icon'],
                                                            color: option[
                                                                'color']),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(option['text'],
                                                            style: TextStyle(
                                                                color: option[
                                                                    'color'])),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: FilledButton(
                                          onPressed: () {
                                            const Popup(
                                                    popupType:
                                                        PopupType.success)
                                                .show(context);
                                          },
                                          child: const Text("Send order")),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send order",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
