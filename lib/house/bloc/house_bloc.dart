import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_ex_digital_practical/house/models/house_details.dart';
import 'package:vision_ex_digital_practical/services/firestore_service.dart';

class HouseCubit extends Cubit<List<HouseDetails>> {
  HouseCubit() : super([]);
  final List<HouseDetails> _allHouses = [];
  final List<HouseDetails> offerList = [];
  Future<void> getHouseData() async {
    try {
      final dataList = await FirestoreService().getDocuments();

      if (dataList.isNotEmpty) {
        final houses =
            dataList.map((house) => HouseDetails.fromMap(house)).toList();

        _allHouses.addAll(houses);
        emit(houses);
        offerList.addAll(
          houses
              .where(
                (house) => (house.title ?? '').toLowerCase().contains('offer'),
              )
              .toList(),
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch house data: $e');
    }
  }

  void searchHouse(String query, {bool? isOffer}) {
    if (query.isEmpty) {
      emit(isOffer == true ? offerList : _allHouses);
    } else {
      if (isOffer == true) {
        final filteredOfferList =
            offerList
                .where(
                  (house) =>
                      (house.title ?? '').toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      (house.location ?? '').toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      house.price.toString().contains(query),
                )
                .toList();

        emit(filteredOfferList);
      } else {
        final filteredList =
            _allHouses
                .where(
                  (house) =>
                      (house.title ?? '').toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      (house.location ?? '').toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      house.price.toString().contains(query),
                )
                .toList();

        emit(filteredList);
      }
    }
  }
}
