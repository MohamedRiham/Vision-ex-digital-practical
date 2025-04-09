import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:vision_ex_digital_practical/house/common_widgets/display_offers_widget.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';

class ViewAllOffersScreen extends StatelessWidget {
  const ViewAllOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Offers')),
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
              final houseCubit = context.read<HouseCubit>();

              return ListView.builder(
                itemCount: houseCubit.offerList.length,
                itemBuilder: (context, index) {
                  return DisplayOffersWidget(
                    houseDetails: houseCubit.offerList[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
