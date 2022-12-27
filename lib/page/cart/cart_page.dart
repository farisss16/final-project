// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/data/model_chart.dart';
import 'package:sneakers_inc/global_controller.dart';
import 'package:sneakers_inc/page/cart/animation_success_pay.dart';
import 'package:sneakers_inc/widget/base/form/form_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/Repository.dart';

enum Menu { BCA, Mandiri, Alfamart, ovo }

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isPesanAntar = true;
  Repository repository = Repository();
  late Future<List<Chart>> futureChart;
  late Future<List<Chart>> futurePayment;
  final gstate = Get.put(GlobalController());
  int shipping = 18000;
  int tax = 3000;

  @override
  void initState() {
    super.initState();
    futureChart = repository.getCharts();
  }

  String _selectedMenu = '';
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Cart",
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/snk2.png',
                          height: 100,
                          width: 100,
                        )
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // isPesanAntar == false
                        //     ? BuildAmbilDirumahView(context)
                        //     : BuildPesanAntarView(context),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Opacity(
                        //   opacity: 1,
                        //   child: Divider(
                        //     color: Colors.grey,
                        //     height: 0.1,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // isPesanAntar == false
                        //     ? BuildOptionOrder(
                        //         context,
                        //         const Icon(
                        //           Icons.home_work,
                        //           color: Colors.white,
                        //         ),
                        //         "Take Away",
                        //         "Pick Up in 1 hour")
                        //     : BuildOptionOrder(
                        //         context,
                        //         const Icon(
                        //           Icons.delivery_dining,
                        //           color: Colors.white,
                        //         ),
                        //         "Delivery Order",
                        //         "Will be delivered at +-3 days after"),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const Divider(
                  //   color: Colors.grey,
                  //   height: 0.1,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    height: 300,
                    width: Get.width,
                    child: FutureBuilder<List<Chart>>(
                      future: futureChart,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Chart> dataItem = snapshot.data!;
                          // for (var n = 0; n <= dataItem.length;n++) {
                          //   gstate.totalPayment.value = gstate.totalPayment.value + dataItem[n].product.harga;
                          // }
                          print(dataItem.length);
                          print("========================================");
                          if (dataItem.length == 1) {
                            return Center(
                              child: BuildItem(item: dataItem[0]),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: dataItem.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return BuildItem(
                                    item: dataItem[index],
                                  );
                                });
                          }
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: const Offset(2.0, 3.0), //(x,y)
                                  blurRadius: 0.1,
                                ),
                              ],
                            ),
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  BuildPembayaranMethod(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 0.1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Payment",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 150,
                              width: Get.width,
                              child: FutureBuilder<List<Chart>>(
                                future: futureChart,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Chart> dataItem = snapshot.data!;
                                    print(dataItem.length);
                                    print(
                                        "========================================");
                                    return ListView.builder(
                                      itemCount: dataItem.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 180,
                                                      child: Text(
                                                        dataItem[index]
                                                            .product
                                                            .name,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        'Rp ${dataItem[index].product.harga.toString()}'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Shipping'),
                                                Text(
                                                    'Rp ${shipping.toString()}')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Tax'),
                                                Text('Rp ${tax.toString()}')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Total'),
                                                Text(
                                                    'Rp ${(dataItem[index].product.harga + shipping + tax)}')
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            offset:
                                                const Offset(2.0, 3.0), //(x,y)
                                            blurRadius: 0.1,
                                          ),
                                        ],
                                      ),
                                      height: 60,
                                      width: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircularProgressIndicator(
                                          color: Color(0xffAFE98B),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.black,
                              height: 0.1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            minimumSize: Size(183, 65),
                          ),
                          onPressed: () {
                            createTransaksi(context);
                          },
                          child: Text(
                            'Order',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // BuildBottomButton(context),
        ]),
      ),
    );
  }

  Container BuildPembayaranMethod() {
    return Container(
      height: 50,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Payment method: $_selectedMenu",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                PopupMenuButton<Menu>(
                  icon: Icon(Icons.arrow_drop_down),
                  // Callback that sets the selected popup menu item.
                  onSelected: (Menu item) {
                    setState(() {
                      _selectedMenu = item.name;
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    const PopupMenuItem<Menu>(
                      value: Menu.BCA,
                      child: Text('BCA'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.Mandiri,
                      child: Text('Mandiri'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.Alfamart,
                      child: Text('Alfamart'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.ovo,
                      child: Text('Ovo'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> createTransaksi(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final gstate = Get.put(GlobalController());
  var token = prefs.getString('token');
  print(token);

  try {
    final response = await http.post(
      Uri.parse('https://api1.sib3.nurulfikri.com/api/transaksi'),
      body: jsonEncode({
        "alamat": gstate.address.value,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 400) {
      print('Connection OK');
      print(response.body);
      final respStr = response.body;
      var body = jsonDecode(respStr);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Transaksi Sukses"),
        ),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AnimationPage(),
          ));
    } else {
      // print('Connection Failed');
      print("Transaksi Gagal");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Transaksi Gagal")));
    }
  } catch (error) {
    print(error);
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Chart item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${item.product.name}",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Rp. ${item.product.harga.toString()}",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Jumlah:${item.qty}",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.product.image,
                    fit: BoxFit.contain,
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
