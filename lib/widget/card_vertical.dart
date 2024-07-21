import 'package:flutter/material.dart';
import 'package:restauran_menu/resource/resource.dart';

class Productsv extends StatelessWidget {
  Productsv({
    super.key,
    this.title,
    this.image,
    this.price,
    this.review,
  });
  String? title;
  String? image;
  String? price;
  String? review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 290,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        color: Colors.white,
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   children: [
                  //     Icon(Icons.star, color: Colors.yellow),
                  //     Text(
                  //       review!,
                  //       style: TextStyle(color: Colors.black54),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: Image.network(image ??
                                      "https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg")
                                  .image,
                              fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$ $price",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          Text(
                            review!,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
