import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:vision_ex_digital_practical/house/screens/details_screen.dart';

class DisplayHouseDetailsWidget extends StatelessWidget {
  final HouseDetails house;
  const DisplayHouseDetailsWidget({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsScreen(houseDetails: house)),
        );
      },

     child: Padding(
        padding: EdgeInsets.all(12.0),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(house.imageUrl ?? ''),
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
                        '\$ ${house.price.toString()}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),

              Text(
                house.title ?? 'N/A',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
