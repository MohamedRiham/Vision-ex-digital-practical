import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:vision_ex_digital_practical/services/firestore_service.dart';

class HouseCubit extends Cubit<List<HouseDetails>> {
  HouseCubit() : super([]);

  Future<void> getHouseData() async {
    try {
      final dataList = await FirestoreService().getDocuments();

      if (dataList.isNotEmpty) {
        final houses =
            dataList.map((house) => HouseDetails.fromMap(house)).toList();
        emit(houses);
      }

    } catch (e) {
      throw Exception('Failed to fetch house data: $e');
    }
  }
}
