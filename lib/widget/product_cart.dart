import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductOnCart extends StatefulWidget {
  const ProductOnCart(
      {super.key,
      this.id,
      this.title,
      this.image,
      this.price,
      this.rating,
      this.jmlview});
  final String? id;
  final String? title;
  final String? image;
  final double? price;
  final double? rating;
  final String? jmlview;

  @override
  State<ProductOnCart> createState() => _ProductOnCartState();
}

class _ProductOnCartState extends State<ProductOnCart> {
  void delete(String? id) async {
    if (id == null) return;
    await FirebaseFirestore.instance.collection("makanan").doc(id).delete();
  }

  @override
  int qty = 0;
  double total = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = (widget.price ?? 0) * qty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              // An action can be bigger than the others.
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              flex: 1,
              onPressed: (context) => delete(widget.id),
              backgroundColor: const Color.fromARGB(255, 251, 121, 0),
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              padding: const EdgeInsets.only(right: 10),
              spacing: 4.0,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2, // changes position of shadow
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: Image.network(widget.image ??
                                  'https://via.placeholder.com/100')
                              .image,
                          fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title ?? 'No Title',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        Text(
                          widget.rating?.toString() ?? '0.0',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.jmlview ?? '(120 Views)',
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "\$ ${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (qty > 0) {
                            qty--;
                          }
                          total = (widget.price ?? 0.0) * qty;
                        });
                      },
                      child: Container(
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.remove,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("$qty"),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          qty++;
                          total = (widget.price ?? 0.0) * qty;
                        });
                      },
                      child: Container(
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.add,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
