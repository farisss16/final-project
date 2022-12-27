import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/page/cart/cart_page.dart';
import 'package:sneakers_inc/page/detailpage/widget/item_description.dart';
import 'package:sneakers_inc/page/detailpage/widget/item_review.dart';
import 'package:sneakers_inc/page/detailpage/widget/widget_topbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/model_products.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({Key? key, required this.product}) : super(key: key);
  final Products product;
  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int activeIndex = 0;
  final controller = CarouselController();
  bool isFavorite = false;

  void setFavorite() {
    setState(() {
      isFavorite = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        splashColor: Colors.black,
        backgroundColor: Colors.white,
        onPressed: () {
          addToCart(widget.product.idProduct);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        bottom: PreferredSize(
                          child: Container(),
                          preferredSize: Size(0, 20),
                        ),
                        pinned: false,
                        expandedHeight: Get.height * 0.4,
                        flexibleSpace: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                color: Colors.white,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: SizedBox(
                                    height: 305,
                                    child: Center(
                                      child: Image.network(
                                        widget.product.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: -220,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: BuildTopBar(
                                  id: widget.product.idProduct,
                                )),
                            Positioned(
                              bottom: -2,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.0, 0.2),
                                      blurRadius: 1,
                                    ),
                                  ],
                                  color: Color(0xffAFE98B),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverFixedExtentList(
                        itemExtent: 1800,
                        delegate: SliverChildListDelegate(
                          [
                            Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffAFE98B),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Get.width,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25.15, right: 24.28),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              widget
                                                                  .product.name,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Rp. ${widget.product.harga.toString()}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                              "${widget.product.stock} remaining")
                                                        ],
                                                      ),
                                                    ),
                                                    BuildCustomDivider(),
                                                    BuildItemDescription(
                                                        description: widget
                                                            .product
                                                            .description),
                                                    BuildCustomDivider(),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text("Review",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black87)),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const BuildItemReview(
                                                        name: 'Shani Indira',
                                                        date: 'Yesteday, 09.28',
                                                        profileImage:
                                                            'assets/shanijkt48.jpeg',
                                                        star: '5',
                                                        review:
                                                            'Sepatunya bagus, legittt original'),
                                                    BuildCustomDivider(),
                                                    const BuildItemReview(
                                                        name: 'Marsha Lenathea',
                                                        date: 'Today, 11.25',
                                                        profileImage:
                                                            'assets/marshajkt48.jpeg',
                                                        star: '5',
                                                        review:
                                                            'Barang bagus walaupun sampenya lama tapi jos lah'),
                                                    BuildCustomDivider(),
                                                    const BuildItemReview(
                                                        name: 'Azizi Shafaa',
                                                        date: 'Today, 11.25',
                                                        profileImage:
                                                            'assets/zeejkt48.jpeg',
                                                        star: '5',
                                                        review:
                                                            'Selalu seneng kalo beli disini, stock selalu ada dan gapernah mengecewakan. bintang 5 deh luvv'),
                                                    BuildCustomDivider(),
                                                    const BuildItemReview(
                                                        name: 'Shania Gracia',
                                                        date: 'Today, 11.25',
                                                        profileImage:
                                                            'assets/graciajkt48.jpeg',
                                                        star: '5',
                                                        review:
                                                            'Pertama kali beli disini dapet bonus shoelace warna hijau kesukaan aku'),
                                                    BuildCustomDivider(),
                                                    const BuildItemReview(
                                                        name: 'Bang don',
                                                        date: 'Today, 11.25',
                                                        profileImage:
                                                            'assets/don.jpeg',
                                                        star: '5',
                                                        review:
                                                            'mantap sepatunya, auto ganteng'),
                                                    BuildCustomDivider(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                //   child: ButtomBuy(product: widget.product),
                // ),
              ],
            ),
            BuildBottomButton(context),
          ],
        ),
      ),
    );
  }

  Positioned BuildBottomButton(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      left: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: Size(0, 50)),
            onPressed: () {
              Get.to(const CartPage());
            },
            child: Row(
              children: const [
                Icon(Icons.shopping_cart_checkout_outlined),
                SizedBox(
                  width: 8,
                ),
                Text('Go To Cart'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildCustomDivider() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          width: 400,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Future<void> addToCart(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print(token);
    print(id);
    try {
      final response = await http.post(
        Uri.parse('https://api1.sib3.nurulfikri.com/api/keranjang'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'product_id': id.toString(),
          'qty': "1",
        }),
      );
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        Get.snackbar(
          'Succeeded',
          'Your Item Has Been Added To Cart',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed',
          'Item failed to be added to cart',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Koneksi Error")));
    }
  }
}

class BuildDetailDescription extends StatelessWidget {
  const BuildDetailDescription(
      {Key? key, required this.detail, required this.icon})
      : super(key: key);
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 15,
              color: Colors.black,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              detail,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

// class ImageProduct extends StatelessWidget {
//   final ProductImage product;
//   const ImageProduct({required this.product, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Container(
//         height: 300,
//         width: Get.width,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(product.image),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     ]);
//   }
// }
