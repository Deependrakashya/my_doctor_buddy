import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  static String get currentUserPhotoUrl {
    final url = FirebaseAuth.instance.currentUser?.photoURL;
    return (url != null && url.isNotEmpty)
        ? url
        : 'https://avatar.iran.liara.run/public';
  }

  static String get currentUserName {
    final name = FirebaseAuth.instance.currentUser?.displayName;
    return (name != null && name.isNotEmpty) ? name : "Anonymous";
  }

  static String get currentUserId {
    final name = FirebaseAuth.instance.currentUser?.uid;
    return (name != null && name.isNotEmpty) ? name : "Anonymous";
  }

  static String get currentUserEmail {
    final email = FirebaseAuth.instance.currentUser?.email;
    return (email != null && email.isNotEmpty) ? email : "Anonymous";
  }
}
