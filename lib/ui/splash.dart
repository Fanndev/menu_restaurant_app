import 'package:flutter/material.dart';
import 'package:restauran_menu/resource/resource.dart';
import 'package:restauran_menu/ui/register.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotosignin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image))),
              )
            ],
          ),
          SizedBox(
            height: 280,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eat",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 60),
                    ),
                    Text(
                      "Easy",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 60,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image2))),
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<void> gotosignin(context) async {
  Future.delayed(Duration(seconds: 5))
      .then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegsiterPage(),
          )));
}
