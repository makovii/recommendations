import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rec_flutter/models/user/user.dart';
import 'package:rec_flutter/route_path.dart';

import 'pages/pages.dart';


GoRouter route(AsyncValue<UserModel> user) {
  return GoRouter(
    routes: [
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: RoutePath.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RoutePath.registration,
        builder: (context, state) => const RegistrationPage(),
      ),
    ],
    initialLocation: RoutePath.home,
    redirect: (BuildContext context, GoRouterState state) {
      if (FirebaseAuth.instance.currentUser == null && state.fullPath != RoutePath.login && state.fullPath != RoutePath.registration) {
        return RoutePath.login;
      }
      return null;
    },
  );
}
