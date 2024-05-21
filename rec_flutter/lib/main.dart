import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rec_flutter/models/user/user.dart';
import 'package:rec_flutter/router.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(dotenv.env['GRAPHQL_URL']!);

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  runApp(ProviderScope(
    child: MyApp(client: client),
  ));
}

class MyApp extends ConsumerWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({super.key, required this.client});
  @override
    Widget build(BuildContext context, WidgetRef ref) {
      final user = ref.watch(userProvider);

      return GraphQLProvider(
        client: client,
        child: MaterialApp.router(
          title: 'Flutter Neo4j GraphQL',
          routerConfig: route(user),
        ),
      );
    }
}
