import 'package:cached_network_image/cached_network_image.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.image,
    required this.title,
    required this.size,
    required this.color,
    required this.price,
    this.add,
    this.minus,
  });

  final String image;
  final String title;
  final String size;
  final String color;
  final double price;
  final Function()? add;
  final Function()? minus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      height: 80.h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondaryCal,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: CachedNetworkImage(
              imageUrl: image,
              height: 64.h(context),
              width: 64.w(context),
              fit: BoxFit.cover,
              memCacheWidth: 200,
              memCacheHeight: 200,
              placeholder: (ctx, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (ctx, url, error) => Icon(Icons.image_not_supported),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, fontFamily: "Circular"),
              ),

              Row(
                children: [
                  Text(
                    "Size - $size",
                    style: TextStyle(fontSize: 12, fontFamily: "Circular"),
                  ),
                  SizedBox(width: 20.s(context)),

                  Text(
                    "Color - $color",
                    style: TextStyle(fontSize: 12, fontFamily: "Circular"),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "\$${price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 12, fontFamily: "Circular"),
              ),

              Row(
                children: [
                  InkWell(
                    onTap: add,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: mainCal,
                      child: Image.asset("assets/img/add.png", height: 20),
                    ),
                  ),
                  SizedBox(width: 10.s(context)),

                  InkWell(
                    onTap: minus,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: mainCal,
                      child: Image.asset("assets/img/minus.png", height: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
