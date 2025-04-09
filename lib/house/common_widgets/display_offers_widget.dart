import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vision_ex_digital_practical/house/screens/details_screen.dart';

class DisplayOffersWidget extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayOffersWidget({super.key, required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(houseDetails: houseDetails),
          ),
        );
      },

      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(houseDetails.imageUrl ?? ''),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10),

                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '\$ ${houseDetails.price.toString()}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(houseDetails.title ?? 'N/A'),
                Text('4.9 (Reviews)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
