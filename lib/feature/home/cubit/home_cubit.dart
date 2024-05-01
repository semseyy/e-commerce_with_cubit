import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    _init();
    _loadFavoriteStatus(); // Uygulama başlatıldığında favori durumunu yükle
  }

  late Timer _timer;

  Future<void> _init() async {
    _startTimer();
  }

  //dispose kısmı
  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      emit(
        state.copyWith(
          currentSubtitleIndex: (state.currentSubtitleIndex + 1) % state.subtitles.length,
        ),
      );
    });
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
    await prefs.setBool("_favoriteKey", isFavorite);
  }

  // SharedPreferences'ten favori durumunu yükleyen fonksiyon
  Future<void> _loadFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isFavorite = prefs.getBool("_favoriteKey");
    if (isFavorite != null) {
      if (isFavorite) {
        emit(state.copyWith(buttonColor: Colors.orange, iconData: Icons.favorite));
      } else {
        emit(state.copyWith(buttonColor: Colors.black, iconData: Icons.favorite_border));
      }
    }
  }

  void setSelectedCategoryIndex(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }
}
