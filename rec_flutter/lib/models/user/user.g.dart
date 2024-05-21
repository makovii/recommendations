// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
      createdTime: _dateTimeFromJson(json['createdTime'] as Object),
      isNewUser: json['isNewUser'] as bool?,
      dateOfBirth: _dateTimeOptionalFromJson(json['dateOfBirth']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'createdTime': instance.createdTime.toIso8601String(),
      'isNewUser': instance.isNewUser,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHash() => r'd2eddbbed61047acf033b418be6341378864c777';

/// See also [User].
@ProviderFor(User)
final userProvider = AsyncNotifierProvider<User, UserModel>.internal(
  User.new,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$User = AsyncNotifier<UserModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
