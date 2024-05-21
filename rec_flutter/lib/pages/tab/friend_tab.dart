import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FriendTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Neo4j with GraphQL in Flutter'),
      // ),
      body: const Text('Need to be implemented')
      // Center(
      //   child: Query(
      //     options: QueryOptions(
      //       document: gql(r'''
      //         query {
      //           movies {
      //             title
      //             released
      //             tagline
      //           }
      //         }
      //       '''),
      //     ),
      //     builder: (QueryResult result, {fetchMore, refetch}) {
      //       if (result.isLoading) {
      //         return const Center(child: CircularProgressIndicator());
      //       }

      //       if (result.hasException) {
      //         return Text(result.exception.toString());
      //       }

      //       final List movies = result.data?['movies'] ?? [];

      //       return ListView.builder(
      //         itemCount: movies.length,
      //         itemBuilder: (context, index) {
      //           final movie = movies[index];
      //           return ListTile(
      //             title: Text(movie['title']),
      //             subtitle: Text('Released: ${movie['released']}, Tagline: ${movie['tagline']}'),
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
