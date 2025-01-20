import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

class ContentDataWidget extends StatelessWidget {
  final String title;
  final String content;
  final double rating;
  const ContentDataWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: title == 'Vendor Rating'
              ? Row(
                  children: [
                    Text(
                      content,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFFbfbfbf)),
                    ),
                    const SizedBox(width: 4),
                    PannableRatingBar(
                      rate: rating,
                      spacing: -3,
                      items: List.generate(
                          5,
                          (index) => const RatingWidget(
                                selectedColor: Colors.yellow,
                                unSelectedColor: Colors.grey,
                                child: Icon(
                                  Icons.star,
                                  size: 16,
                                ),
                              )),
                      onChanged: null,
                    )
                  ],
                )
              : Text(
                  content,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFFbfbfbf)),
                ),
        )
      ],
    );
  }
}
