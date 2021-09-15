import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/customer_review.dart';

class CardReview extends StatelessWidget {
  final CustomerReview review;

  const CardReview({
    Key key,
    @required this.review
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[400],
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            review.name ?? "",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Text(
            review.review ?? "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.grey[600], fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}