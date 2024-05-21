import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rec_flutter/graphql/graphql.dart';


class MovieTab extends StatelessWidget {
  const MovieTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Query(
          options: QueryOptions(
            document: gql(getMovies),
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (result.hasException) {
              return Text(result.exception.toString());
            }

            final List movies = result.data?['movies'] ?? [];

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text('Released: ${movie['released']}, Tagline: ${movie['tagline']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
