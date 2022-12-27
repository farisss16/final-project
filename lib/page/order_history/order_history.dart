import 'package:flutter/material.dart';
import 'package:sneakers_inc/data/Repository.dart';
import 'package:sneakers_inc/data/model_history.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  Repository repository = Repository();
  late Future<List<BuyHostory>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = repository.getBuyHistorys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Order"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffAFE98B),
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<BuyHostory>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BuyHostory> dataItem = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return BuildItem(buyHostory: dataItem[index]);
                  },
                  itemCount: dataItem.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(100),
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
              );
            }
            return Padding(
              padding: const EdgeInsets.all(100),
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
            );
          },
        ),
      ),
    );
  }
}

class BuildItem extends StatefulWidget {
  const BuildItem({Key? key, required this.buyHostory}) : super(key: key);

  final BuyHostory buyHostory;
  @override
  State<BuildItem> createState() => _BuildItemState();
}

class _BuildItemState extends State<BuildItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.00, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 10.0, color: Colors.grey.shade100),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.buyHostory.dateOrder,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.network(widget.buyHostory.products[0].image),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Rp. ${widget.buyHostory.total.toString()}",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // time,
                        "${widget.buyHostory.products.length} Pesanan",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.grey,
            height: 0.1,
            thickness: 0.1,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
