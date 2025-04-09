import 'package:cached_network_image/cached_network_image.dart';
import 'package:vision_ex_digital_practical/account/bloc/account_bloc.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/common_widgets/search_bar.dart';
import 'package:vision_ex_digital_practical/common_widgets/side_draw.dart';
import 'package:vision_ex_digital_practical/house/screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HI, ${context.read<AccountCubit>().state?.username}'),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchBox(height: 50.0, hiddenText: 'Search', search: (value) {}),

              _buildTitle('Featured'),
              SizedBox(
                height: 200,
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
                      return GridView.builder(
                        shrinkWrap: true,

                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                            ),

                        itemCount: houses.length,
                        itemBuilder: (context, index) {
                          final house = houses[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => DetailsScreen(houseDetails: house),
                                ),
                              );
                            },

                            child: Padding(
                              padding: EdgeInsets.all(12.0),

                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),

                                            child: CachedNetworkImage(
                                              width: double.infinity,
                                              imageUrl: house.imageUrl ?? '',
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
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),

                                              child: Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,

                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.0,
                                                      ),
                                                ),
                                                child: Text(
                                                  '\$ ${house.price.toString()}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          house.title ?? 'N/A',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 16),

              _buildTitle('New offers'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String titleText) {
    return Padding(
      padding: EdgeInsets.all(12.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titleText, style: TextStyle(fontSize: 18, color: Colors.black)),
          InkWell(onTap: () {}, child: Text('View all')),
        ],
      ),
    );
  }
}
