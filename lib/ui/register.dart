import 'package:flutter/material.dart';
import 'package:restauran_menu/ui/register_email.dart';
import 'package:restauran_menu/widget/button.dart';
import 'package:restauran_menu/widget/popup.dart';

class RegsiterPage extends StatelessWidget {
  const RegsiterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Let's Get Started 😁",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Sign up or login into to have a full digital experience in our restaurant",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterEmail(),
                            ));
                      },
                      child: const Text("Get Started"),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: const Text(
                              "OR",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: "Login with Gmail",
                    onPress: () {
                      const Popup(popupType: PopupType.comingsoon)
                          .show(context);
                    },
                    height: 60,
                    width: double.infinity,
                    image:
                        "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    title: "Login with Facebook",
                    onPress: () {
                      const Popup(popupType: PopupType.comingsoon)
                          .show(context);
                    },
                    heightimg: 30,
                    widthimg: 30,
                    height: 60,
                    width: double.infinity,
                    image:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtfbcYeYgf0wQJ-LSPm3CPbyB7T1p0f5bnaA&s",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
