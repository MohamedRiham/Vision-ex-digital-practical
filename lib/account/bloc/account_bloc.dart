import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/account.dart';

class AccountCubit extends Cubit<Account?> {
  AccountCubit() : super(null);

  Future<void> saveAccount(Account account) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(account.toMap());
      await prefs.setString('account_data', jsonString);
      emit(account);
    } catch (_) {
      throw Exception('An error occurred');
    }
  }

  Future<void> loadAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('account_data');
      if (jsonString != null) {
        final data = jsonDecode(jsonString);
        emit(Account.fromMap(data));
      } else {
        emit(null);
      }
    } catch (_) {
      emit(null);
      throw Exception('An error occurred');
    }
  }
}
