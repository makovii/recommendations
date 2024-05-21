import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rec_flutter/models/user/user.dart';
import 'package:rec_flutter/route_path.dart';

class DrawerComponentWidget extends ConsumerStatefulWidget {
  const DrawerComponentWidget({super.key});

  @override
  ConsumerState<DrawerComponentWidget> createState() => _DrawerComponentWidgetState();
}

class _DrawerComponentWidgetState extends ConsumerState<DrawerComponentWidget> {

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
            child: Text(
              'Account Options',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser?.photoURL?? '',
              ),
            ),
            title: const DisplayName(),
            subtitle: const DisplayEmail(),
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.go(RoutePath.login);
            },
            child: const ListTile(
              leading: Icon(Icons.login_rounded),
              title: Text('Log out'),
            ),
          ),
        ],
      ),
    );
  }
}


class DisplayName extends ConsumerWidget {
  const DisplayName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    return Text(
      user.value?.name ?? 'defaultName',
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DisplayEmail extends ConsumerWidget {
  const DisplayEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    return Text(
      user.value?.email ?? "",
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
