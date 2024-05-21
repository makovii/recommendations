import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rec_flutter/models/user/user.dart';

const String createUserMutation = r'''
mutation createUser($input: CreateUserInput) {
  createUser(input: $input) {
    uid
    name
    email
    createdTime
    isNewUser
    dateOfBirth
  }
}
''';

Future<void> createUser(GraphQLClient client, UserModel user) async {
  final MutationOptions options = MutationOptions(
    document: gql(createUserMutation),
    variables: <String, dynamic>{
      'input': {
        'uid': user.uid,
        'name': user.name,
        'email': user.email,
        'createdTime': user.createdTime.toIso8601String(),
        'isNewUser': user.isNewUser,
        'dateOfBirth': user.dateOfBirth?.toIso8601String(),
      },
    },
  );

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    print(result.exception.toString());
  } else {
  final userData = result.data!['createUser'];
  final createdUser = UserModel(
    uid: userData['uid'],
    name: userData['name'],
    email: userData['email'],
    createdTime: DateTime.parse(userData['createdTime']),
    isNewUser: userData['isNewUser'],
    dateOfBirth: userData['dateOfBirth'] != null
        ? DateTime.parse(userData['dateOfBirth'])
        : null,
  );
  print('User created: $createdUser');
}
}
