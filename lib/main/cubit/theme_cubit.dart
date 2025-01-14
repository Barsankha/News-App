// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<bool> {
  static const String themeKey = 'isdark';
  // ignore: use_super_parameters
  ThemeCubit(bool isdark) : super(isdark) {
    loadtheme();
  }
  void loadtheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isdark = prefs.getBool(themeKey) ?? false;
    emit(isdark);
  }

  void toggletheme() async {
    final newdark = !state;
    emit(newdark);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, newdark);
  }
}
