import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restauran_menu/ui/home.dart';
import 'package:restauran_menu/ui/login.dart';

class RegisterEmail extends StatefulWidget {
  const RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController noHP = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isPassword = true;
  bool isValueInputname = false;
  bool isValueInputemail = false;
  bool isValueInputnoHP = false;
  final _formkey = GlobalKey<FormState>();

  void _registerUser() async {
    if (_formkey.currentState!.validate()) {
      if (password.text == confirmPassword.text) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email.text, password: password.text);
          print('User registered: ${userCredential.user?.uid}');
          // Optionally save additional user data to a database here
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Registration Successful'),
                content: const Text('Thank you for registering!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: Text('${e.message}'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text('Your Passwords Do Not Match!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff7f7f7),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: Column(
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      "Getting started! ✌️",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "Look like you are new to us! Create an account for a complete digital experience",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: username,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {
                                isValueInputname = value.isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Username",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hoverColor: Colors.black,
                              fillColor: Colors.white,
                              suffixIcon: isValueInputname
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.green,
                                    )
                                  : null,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                isValueInputemail = value.isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Email",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hoverColor: Colors.black,
                              fillColor: Colors.white,
                              suffixIcon: isValueInputemail
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.green,
                                    )
                                  : null,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: noHP,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                isValueInputnoHP = value.isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Phone number",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hoverColor: Colors.black,
                              fillColor: Colors.white,
                              prefixText: "+62 | ",
                              suffixIcon: isValueInputnoHP
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.green,
                                    )
                                  : null,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password,
                            obscureText: isPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Password",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hoverColor: Colors.black,
                              fillColor: Colors.white,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPassword,
                            obscureText: isPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Confirm Your Password';
                              }
                              if (value != confirmPassword.text) {
                                return 'Passwords Do Not Match';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Confirm Password",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hoverColor: Colors.black,
                              fillColor: Colors.white,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                _registerUser();
                              },
                              child: const Text("Next"),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text("Login"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
