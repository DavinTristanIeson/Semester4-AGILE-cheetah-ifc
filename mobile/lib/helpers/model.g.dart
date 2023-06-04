// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      img: json['img'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'img': instance.img,
      'price': instance.price,
    };

MenuOrder _$MenuOrderFromJson(Map<String, dynamic> json) => MenuOrder(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      img: json['img'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int? ?? 1,
      note: json['note'] as String? ?? "",
    );

Map<String, dynamic> _$MenuOrderToJson(MenuOrder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'img': instance.img,
      'price': instance.price,
      'quantity': instance.quantity,
      'note': instance.note,
    };

MenuTransactionRecord _$MenuTransactionRecordFromJson(
        Map<String, dynamic> json) =>
    MenuTransactionRecord(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      note: json['note'] as String,
    );

Map<String, dynamic> _$MenuTransactionRecordToJson(
        MenuTransactionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'note': instance.note,
    };

MenuTransaction _$MenuTransactionFromJson(Map<String, dynamic> json) =>
    MenuTransaction(
      id: json['id'] as int,
      user: json['user'] as String,
      time: DateTime.parse(json['time'] as String),
      records: (json['records'] as List<dynamic>)
          .map((e) => MenuTransactionRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$OngoingOrderPhaseEnumMap, json['status']),
    );

Map<String, dynamic> _$MenuTransactionToJson(MenuTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'time': instance.time.toIso8601String(),
      'records': instance.records,
      'status': _$OngoingOrderPhaseEnumMap[instance.status]!,
    };

const _$OngoingOrderPhaseEnumMap = {
  OngoingOrderPhase.Pending: 2,
  OngoingOrderPhase.Cooking: 1,
  OngoingOrderPhase.Finished: 0,
  OngoingOrderPhase.Canceled: -1,
};

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      telp: json['telp'] as String,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender]!,
      'telp': instance.telp,
    };

const _$GenderEnumMap = {
  Gender.Male: 1,
  Gender.Female: 0,
};
