import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/data/Repository.dart';
import 'package:sneakers_inc/data/model_category.dart';
import 'package:sneakers_inc/data/model_products.dart';
import 'package:sneakers_inc/data/model_wishlists.dart';
import 'package:sneakers_inc/page/home/widget/item_widget_vertical.dart';
import 'package:sneakers_inc/page/wishlists/item_widget.dart';

class WishlistsPage extends StatefulWidget {
  const WishlistsPage({Key? key}) : super(key: key);

  @override
  State<WishlistsPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<WishlistsPage> {
  Repository repository = Repository();
  late Future<List<Wishlists>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = repository.getWishlists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        centerTitle: true,
        backgroundColor: Color(0xffAFE98B),
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            FutureBuilder<List<Wishlists>>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Wishlists> dataItem = snapshot.data!;
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
                          return ItemWidget(product: dataItem[index]);
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
                          child: const Padding(
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
                        child: const Padding(
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
