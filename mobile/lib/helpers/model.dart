import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

String formatRupiah(int price) {
  List<int> pieces = [];
  while (price > 0) {
    pieces.add(price % 1000);
    price = (price / 1000).round();
  }
  return "Rp. ${pieces.reversed.join('.')}";
}

@JsonSerializable()
class MenuItem {
  final int id;
  String name;
  String category;
  String description;
  String img;
  int price;
  MenuItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.description,
      required this.img,
      required this.price});
  String get harga {
    return formatRupiah(price);
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable()
class MenuOrder extends MenuItem {
  int quantity;
  String note;
  MenuOrder(
      {required super.id,
      required super.name,
      required super.category,
      required super.description,
      required super.img,
      required super.price,
      this.quantity = 1,
      this.note = ""});

  MenuOrder.from({required MenuItem item, this.quantity = 1, this.note = ""})
      : super(
          id: item.id,
          name: item.name,
          category: item.category,
          description: item.description,
          img: item.img,
          price: item.price,
        );
  @override
  String get harga {
    return formatRupiah(price * quantity);
  }

  factory MenuOrder.fromJson(Map<String, dynamic> json) =>
      _$MenuOrderFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MenuOrderToJson(this);
}

enum OngoingOrderPhase {
  @JsonValue(2)
  Pending,
  @JsonValue(1)
  Cooking,
  @JsonValue(0)
  Finished,
  @JsonValue(-1)
  Canceled,
}

extension on OngoingOrderPhase {
  // ignore: unused_element
  String stringify() {
    switch (this) {
      case OngoingOrderPhase.Pending:
        return "Pending";
      case OngoingOrderPhase.Cooking:
        return "Cooking";
      case OngoingOrderPhase.Finished:
        return "Finished";
      case OngoingOrderPhase.Canceled:
        return "Canceled";
    }
  }

  // ignore: unused_element
  int toInt() {
    switch (this) {
      case OngoingOrderPhase.Pending:
        return 2;
      case OngoingOrderPhase.Cooking:
        return 1;
      case OngoingOrderPhase.Finished:
        return 0;
      case OngoingOrderPhase.Canceled:
        return -1;
    }
  }

  // ignore: unused_element
  static OngoingOrderPhase parse(int status) {
    switch (status) {
      case 0:
        return OngoingOrderPhase.Pending;
      case 1:
        return OngoingOrderPhase.Cooking;
      case -1:
        return OngoingOrderPhase.Canceled;
      default:
        return OngoingOrderPhase.Pending;
    }
  }
}

@JsonSerializable()
class MenuTransaction {
  final int id;
  String username;
  DateTime time;
  List<MenuOrder> orders;
  OngoingOrderPhase phase;
  MenuTransaction({
    required this.id,
    required this.username,
    required this.time,
    required this.orders,
    required this.phase,
  });
  String _pad0(int num) {
    return num.toString().padLeft(2, '0');
  }

  String get timeString {
    return "${_pad0(time.day)}/${_pad0(time.month)}/${_pad0(time.year)}, ${_pad0(time.hour)}:${_pad0(time.minute)}";
  }

  int get totalPrice {
    return orders
        .map((x) => x.price)
        .reduce((value, element) => value + element);
  }

  String get hargaTotal {
    return formatRupiah(totalPrice);
  }

  factory MenuTransaction.fromJson(Map<String, dynamic> json) =>
      _$MenuTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$MenuTransactionToJson(this);
}

enum Gender {
  @JsonValue(1)
  Male,
  @JsonValue(0)
  Female,
}

@JsonSerializable()
class UserAccount {
  final int id;
  String email;
  String name;
  Gender gender;
  String telp;
  UserAccount({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.telp,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);
  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
