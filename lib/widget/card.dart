import 'package:flutter/material.dart';
import 'package:restauran_menu/resource/resource.dart';
import 'package:restauran_menu/ui/detailProduct.dart';

class Product extends StatelessWidget {
  Product(
      {super.key,
      this.title,
      this.image,
      this.price,
      this.review,
      this.jmlview});
  String? title;
  String? image;
  String? price;
  String? review;
  String? jmlview;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detailproduct(),
            ));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage(image!), fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(
                        review!,
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        jmlview!,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "\$ $price",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
