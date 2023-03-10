import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class BuildItemDescription extends StatelessWidget {
  const BuildItemDescription({Key? key, required this.description})
      : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: Get.width,
        // height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            const SizedBox(
              height: 5,
            ),
            ReadMoreText(
              description == "-"
                  ? 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.'
                  : description,
              trimLines: 4,
              colorClickableText: Colors.white,
              trimMode: TrimMode.Line,
              trimCollapsedText: '...Show more',
              // preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
              trimExpandedText: '...Show less',
              style: const TextStyle(height: 1.5),
              moreStyle: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.justify,

              // ),
            ),
            // Text(
            //   "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.",
            //   style: TextStyle(fontSize: 12, color: Color.fromARGB(221, 15, 15, 15),  height: 1.5),
            //   textAlign: TextAlign.justify,
            // ),
          ],
        ),
      ),
    ]);
  }
}
