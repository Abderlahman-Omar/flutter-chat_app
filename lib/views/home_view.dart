// // import 'package:chat_app/views/register_view.dart';
// import 'package:chat_app/constants.dart';
// import 'package:chat_app/views/register_view.dart';
// import 'package:chat_app/widgets/custom_button.dart';
// import 'package:chat_app/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});
//   static String id = 'HomeView';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: 12,
//           right: 12,
//         ),
//         child: Center(
//           child: ListView(
//             children: [
//               const SizedBox(
//                 height: 75,
//               ),
//               Image.asset(
//                 'assets/images/scholar.png',
//                 height: 100,
//               ),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Scholar Chat',
//                     style: TextStyle(
//                       fontFamily: 'pacifico',
//                       color: Colors.white,
//                       fontSize: 32,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 75,
//                   ),
//                 ],
//               ),
//               const Row(
//                 children: [
//                   Text(
//                     'Sign In',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               const CustomTextField(
//                 hintText: 'Enter Email',
//                 hintColor: Colors.white,
//                 labelText: 'Email',
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const CustomTextField(
//                 hintText: 'Enter Password',
//                 hintColor: Colors.white,
//                 labelText: 'Password',
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               const CustomButton(
//                 btnText: 'Sign In',
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'don\'t have an account ?',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, RegisterView.id);
//                     },
//                     child: const Text(
//                       '  Sign Up',
//                       style: TextStyle(
//                         color: Color(0xffC7EDE6),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:chat_app/views/home_view.dart';

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  HomeView({
    super.key,
  });
  static String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontFamily: 'pacifico',
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Enter Email',
                    hintColor: Colors.white,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Enter Password',
                    hintColor: Colors.white,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          showSnackBar(context, 'logged in successfuly');
                          isLoading = false;
                          setState(() {});
                          Navigator.pushNamed(context, 'ChatPage',
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'No user found for that email');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user.');
                          } else {
                            showSnackBar(context, 'something went wrong');
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      } else {}
                    },
                    btnText: 'Sign In',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account ?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterView.id);
                        },
                        child: const Text(
                          '  Sign Up',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
