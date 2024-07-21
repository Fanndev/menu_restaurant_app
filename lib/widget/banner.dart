import 'package:flutter/material.dart';
import 'package:restauran_menu/resource/resource.dart';

class Banners extends StatelessWidget {
  Banners({super.key, this.title, this.image, this.price, this.subtitle});
  String? title;
  String? subtitle;
  String? image;
  String? price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.black,
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subtitle!,
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$ $price",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: AssetImage(image!), fit: BoxFit.cover)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
