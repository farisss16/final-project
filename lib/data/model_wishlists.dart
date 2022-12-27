import 'package:sneakers_inc/data/model_products.dart';

class Wishlists {
  final int id;
  Products product;

  Wishlists({
    required this.id,
    required this.product,
  });

  factory Wishlists.fromJson(Map<String, dynamic> json) {
    return Wishlists(
      id: json['id'],
      product: Products.fromJson(json['product']),
    );
  }
}
