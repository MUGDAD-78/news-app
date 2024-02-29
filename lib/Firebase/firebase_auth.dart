import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/Models/firebaseModel.dart';
import 'package:news_app/constant/alert_dilog.dart';

class FirebaseAuthFunc {
  registerMethod(
      {required email,
      required password,
      required userName,
      required context}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      CollectionReference users =
          FirebaseFirestore.instance.collection('Userinfo');

      UserData userData = UserData(
        uid: FirebaseAuth.instance.currentUser!.uid,
        userName: userName,
        email: email,
        password: password,
      );
      users
          .doc(credential.user!.uid)
          .set(
            userData.convert2Map(),
          )
          // ignore: avoid_print
          .then((value) => print("User Added"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to merge data: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertDilog(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showAlertDilog(context,
            'The account already exists for that email,please colse the app and open it again .');
      }
// ignore: empty_catches
    } catch (e) {
      showAlertDilog(context, e.toString());
    }
  }

  signInMethod({required email, required password, context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDilog(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        showAlertDilog(context, "Wrong password provided for that user.");
      } else {
        showAlertDilog(context, "Error");
      }
      showAlertDilog(context, "EROOR : ${e.code}");
    }
  }
}

// registerMethod() async {
//   try {
//     final credential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: passwordController.text,
//     );

//     CollectionReference users =
//         FirebaseFirestore.instance.collection('Userinfo');

//     UserData userData = UserData(
//       uid: FirebaseAuth.instance.currentUser!.uid,
//       userName: usernameController.text,
//       email: emailController.text,
//       password: passwordController.text,
//     );
//     users
//         .doc(credential.user!.uid)
//         .set(
//           userData.convert2Map(),
//         )
//         .then((value) => print("User Added"))
//         .catchError((error) => print("Failed to merge data: $error"));
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       showAlertDilog(context, 'The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       showAlertDilog(context,
//           'The account already exists for that email,please colse the app and open it again .');
//     }
//   } catch (e) {
//     showAlertDilog(context, e.toString());
//   }
// }
