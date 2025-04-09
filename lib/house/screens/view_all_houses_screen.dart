import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:vision_ex_digital_practical/house/common_widgets/display_house_details_widget.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';

class ViewAllHousesScreen extends StatelessWidget {
  const ViewAllHousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Houses')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: houses.length,
                itemBuilder: (context, index) {
                  final house = houses[index];
                  return DisplayHouseDetailsWidget(house: house);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
