// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class BuildItemReview extends StatelessWidget {
  const BuildItemReview(
      {Key? key,
      required this.profileImage,
      required this.date,
      required this.review,
      required this.star,
      required this.name})
      : super(key: key);
  final String profileImage;
  final String date;
  final String review;
  final String star;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    profileImage,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          star,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(
              date,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        ReadMoreText(
          review,
          trimLines: 4,
          colorClickableText: Colors.white,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...Show more',
          // preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
          trimExpandedText: '...Show less',
          style: const TextStyle(height: 1.5),
          moreStyle: TextStyle(fontSize: 14, color: Colors.white),
          textAlign: TextAlign.left,

          // ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/review.jpeg",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
