import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/data/Repository.dart';
import 'package:sneakers_inc/data/model_products.dart';
import 'package:sneakers_inc/page/home/widget/item_widget_vertical.dart';

class ListItemPage extends StatefulWidget {
  const ListItemPage({Key? key, required this.id}) : super(key: key);

  final String id;
  @override
  State<ListItemPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> {
  Repository repository = Repository();
  late Future<List<Products>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = repository.getCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              expandedHeight: 75.0,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
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
                          return ItemWidgetVercital(product: dataItem[index]);
                        },
                        childCount: dataItem.length,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverPadding(
                    padding: EdgeInsets.all(100),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: Offset(2.0, 3.0), //(x,y)
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
                          padding: EdgeInsets.all(10.0),
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
