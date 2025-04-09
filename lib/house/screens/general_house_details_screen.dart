import 'package:vision_ex_digital_practical/account/bloc/account_bloc.dart';
import 'package:vision_ex_digital_practical/house/common_widgets/display_house_details_widget.dart';
import 'package:vision_ex_digital_practical/house/common_widgets/display_offers_widget.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/common_widgets/search_bar.dart';
import 'package:vision_ex_digital_practical/common_widgets/side_draw.dart';
import 'package:vision_ex_digital_practical/house/screens/view_all_houses_screen.dart';
import 'package:vision_ex_digital_practical/house/screens/view_all_offers_screen.dart';

class GeneralHouseDetailsScreen extends StatelessWidget {
  const GeneralHouseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HI, ${context.read<AccountCubit>().state?.username}'),
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
                final houseCubit = context.read<HouseCubit>();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SearchBox(
                      height: 50.0,
                      hiddenText: 'Search',
                      search: (value) {
                        context.read<HouseCubit>().searchHouse(value);
                      },
                      onChange: (value) {
                        if (value.isEmpty) {
                          context.read<HouseCubit>().searchHouse('');
                        }
                      },
                    ),

                    _buildTitle('Featured', () {
                      Navigator.of(
                        context,
                      ).push(_createRoute(ViewAllHousesScreen()));
                    }),

                    SizedBox(
                      height: 200,
                      child: GridView.builder(
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
                          return DisplayHouseDetailsWidget(house: house);
                        },
                      ),
                    ),
                    SizedBox(height: 16),

                    _buildTitle('New offers', () {
                      Navigator.of(
                        context,
                      ).push(_createRoute(ViewAllOffersScreen()));
                    }),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: houseCubit.offerList.length,
                        itemBuilder: (context, index) {
                          return DisplayOffersWidget(
                            houseDetails: houseCubit.offerList[index],
                          );
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

  Widget _buildTitle(String titleText, VoidCallback navigate) {
    return Padding(
      padding: EdgeInsets.all(12.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titleText, style: TextStyle(fontSize: 18, color: Colors.black)),
          InkWell(onTap: navigate, child: Text('View all')),
        ],
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
