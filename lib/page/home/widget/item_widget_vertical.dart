import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/data/model_category.dart';
import 'package:sneakers_inc/data/model_products.dart';
import 'package:sneakers_inc/page/detailpage/detail_product_page.dart';

class ItemWidgetVercital extends StatelessWidget {
  const ItemWidgetVercital({Key? key, required this.product}) : super(key: key);

  final Products product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailProductPage(product: product));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: Offset(2.0, 3.0), //(x,y)
              blurRadius: 0.1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: SizedBox(
                height: 120,
                child: Center(
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 20,
              width: 150,
              child: Text(
                product.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              height: 20,
              width: 300,
              child: Text(
                "Rp. ${product.harga.toString()}",
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
