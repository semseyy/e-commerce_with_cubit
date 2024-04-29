import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final String _favoriteKey = 'favoriteStatus'; // Favori durumunu saklamak için anahtar

  HomeCubit() : super(HomeState.initial()) {
    _loadFavoriteStatus(); // Uygulama başlatıldığında favori durumunu yükle
  }

  void addFavorite() async {
    if (state.buttonColor == Colors.black) {
      emit(
        state.copyWith(buttonColor: Colors.orange, iconData: Icons.favorite),
      );
      await _saveFavoriteStatus(true); // Favori eklendiğinde durumu sakla
    } else {
      emit(
        state.copyWith(buttonColor: Colors.black, iconData: Icons.favorite_border),
      );
      await _saveFavoriteStatus(false); // Favori kaldırıldığında durumu sakla
    }
  }

  void setSize(String size) {
    emit(
      state.copyWith(selectedSize: size),
    );
  }

  // Favori durumunu SharedPreferences'te saklayan fonksiyon
  Future<void> _saveFavoriteStatus(bool isFavorite) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_favoriteKey, isFavorite);
  }

  // SharedPreferences'ten favori durumunu yükleyen fonksiyon
  Future<void> _loadFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isFavorite = prefs.getBool(_favoriteKey);
    if (isFavorite != null) {
      if (isFavorite) {
        emit(state.copyWith(buttonColor: Colors.orange, iconData: Icons.favorite));
      } else {
        emit(state.copyWith(buttonColor: Colors.black, iconData: Icons.favorite_border));
      }
    }
  }
}
