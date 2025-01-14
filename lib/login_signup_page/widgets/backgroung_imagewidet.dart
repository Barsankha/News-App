import 'dart:ui'; // Required for ImageFilter;
import 'package:channel_1/login_signup_page/widgets/bottoms.dart';
import 'package:channel_1/login_signup_page/widgets/text_field.dart';
import 'package:channel_1/login_signup_page/widgets/tiles.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final bool isLoading;
  final String title;
  final String bottomtitle;
  final String bottomtitle2;
  final GlobalKey<FormState> formKey;
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onpage; //homescreen
  final Future<void> Function()? ontap;
  final Future<void> Function()? ongoogle;
  final Function onlook; //welcomepage

  const SignUpScreen({
    super.key,
    required this.isLoading,
    required this.formKey,
    this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.ontap,
    required this.ongoogle,
    required this.title,
    required this.bottomtitle,
    required this.bottomtitle2,
    required this.onpage,
    required this.onlook,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/news1.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                          ),
                          color: Colors.black87,
                          onPressed: () {
                            onpage();
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(title,
                            style: const TextStyle(
                                color: Colors.teal,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Form(
                                key: formKey,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (nameController != null)
                                        MyTextField(
                                          controller: nameController!,
                                          hintText: 'Name',
                                          obscureText: false,
                                          icon: const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                          text: 'Full name',
                                        ),
                                      const SizedBox(height: 10),
                                      MyTextField(
                                        controller: emailController,
                                        hintText: 'Email',
                                        obscureText: false,
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        ),
                                        text: 'Email',
                                      ),
                                      const SizedBox(height: 10),
                                      MyPasswordTextField(
                                        controller: passwordController,
                                        hintText: 'Password',
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015),
                                      // Sign Up button
                                      MyButton(
                                        onTap: () async {
                                          await ontap?.call();
                                        },
                                        text: "Continue",
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              thickness: 0.5,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              'Or',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              thickness: 0.5,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Google button
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SquareTile(
                                              imagePath:
                                                  'assets/google_logo.png',
                                              title: "Continue with Google",
                                              onPressed: () async {
                                                await ongoogle?.call();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Not a member? Register now
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bottomtitle,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(width: 4),
                                                GestureDetector(
                                                  onTap: () {
                                                    onlook();
                                                  },
                                                  child: Text(
                                                    bottomtitle2,
                                                    style: const TextStyle(
                                                      color: Colors.teal,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
