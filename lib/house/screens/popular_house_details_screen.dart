import 'package:cached_network_image/cached_network_image.dart';
import 'package:vision_ex_digital_practical/common_widgets/side_draw.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/common_widgets/search_bar.dart';

class PopularHouseDetailsScreen extends StatelessWidget {
  const PopularHouseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder:
                  (context) => Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); // Open Drawer
                      },
                      icon: Icon(Icons.menu, color: Colors.white),
                    ),
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SearchBox(
                  height: 50,
                  hiddenText: 'Search',
                  search: (value) {
                    context.read<HouseCubit>().searchHouse(
                      value,
                      isOffer: true,
                    );
                  },
                  onChange: (value) {
                    if (value.isEmpty) {
                      context.read<HouseCubit>().searchHouse('', isOffer: true);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocBuilder<HouseCubit, List<HouseDetails>>(
            builder: (context, houses) {
              if (houses.isEmpty) {
                return Center(
                  child: Text(
                    'No details available',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              } else {
                final houseCubit = context.watch<HouseCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Popular rent offers',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: houseCubit.offerList.length,
                        itemBuilder: (context, index) {
                          return _buildDetails(houseCubit.offerList[index]);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(HouseDetails details) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(details.imageUrl ?? ''),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10),

                child: Row(
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${details.numberOfBeds} Beds',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${details.numberOfBathRooms} Bathroom',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                details.title ?? 'N/A',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                '\$ ${details.price.toString()}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  details.location ?? 'N/A',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.ellipsis, // optional
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
