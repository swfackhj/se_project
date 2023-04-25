// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      eamil: json['eamil'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      club: json['club'] as String,
      emailVerified: json['emailVerified'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'eamil': instance.eamil,
      'password': instance.password,
      'name': instance.name,
      'gender': instance.gender,
      'club': instance.club,
      'emailVerified': instance.emailVerified,
    };
