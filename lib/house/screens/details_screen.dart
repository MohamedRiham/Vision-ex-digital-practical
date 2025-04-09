import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';

class DetailsScreen extends StatelessWidget {
  final HouseDetails houseDetails;
  const DetailsScreen({required this.houseDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.title ?? 'N/A'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(
              16,
            ),

            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              imageUrl: houseDetails.imageUrl ?? '',
              placeholder:
                  (context, url) => Center(
                child:
                CircularProgressIndicator(),
              ),
              errorWidget:
                  (
                  context,
                  url,
                  error,
                  ) => Image.asset(
                'assets/images/placeholder.png',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            houseDetails.title ?? 'N/A',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              Text(houseDetails.location ?? 'N/A'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$ ${houseDetails.price?.toString() ?? 0}',
            style: const TextStyle(fontSize: 20, color: Colors.green),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
