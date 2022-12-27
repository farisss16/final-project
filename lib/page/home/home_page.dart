// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/data/Repository.dart';
import 'package:sneakers_inc/data/data_product.dart';
import 'package:sneakers_inc/data/model_category.dart';
import 'package:sneakers_inc/data/model_products.dart';
import 'package:sneakers_inc/page/cart/cart_page.dart';
import 'package:sneakers_inc/page/home/widget/mydrawerlist.dart';
import 'package:sneakers_inc/page/home/widget/myheaddraw.dart';
import 'package:sneakers_inc/page/wishlists/wishlist_page.dart';
import 'widget/item_widget_category.dart';
import 'widget/item_widget_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Repository repository = Repository();
  late Future<List<Products>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = repository.getProdacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffAFE98B),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        title: Text('Sneakers Inc.'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 23.0, vertical: 16),
              sliver: SliverFixedExtentList(
                itemExtent: 220,
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryDummy.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemWidgetCategory(
                                category: categoryDummy[index]);
                          },
                        ),
                      ),
                      const Text(
                        "Products",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            FutureBuilder<List<Products>>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Products> dataItem = snapshot.data!;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        mainAxisExtent: 200,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ItemWidgetProduct(product: dataItem[index]);
                        },
                        childCount: dataItem.length,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(100),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: const Offset(2.0, 3.0), //(x,y)
                                blurRadius: 0.1,
                              ),
                            ],
                          ),
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.error_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(100),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(2.0, 3.0), //(x,y)
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
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
