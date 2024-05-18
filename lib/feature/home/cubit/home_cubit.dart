import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/home_model.dart';
import '../service/home_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    _init();
    _loadFavoriteStatus();
  }

  late Timer _timer;

  final List<String> categories = ["electronics", "jewelery", "men's clothing", "women's clothing"];

  Future<void> _init() async {
    await fetchProducts();
    emit(state.copyWith(categories: categories));
    _startTimer();
  }

  Future<void> fetchProducts() async {
    try {
      final List<Product> products = await FakeStoreService().getProducts();
      final List<String> productImages =
          products.map((product) => product.imageUrl).toList().sublist(0, 3); // Sadece ilk üç ürün resmini al
      emit(state.copyWith(
          products: products,
          productImages: productImages,
          searchedProducts: products)); // Arama sonuçlarına başlangıçta tüm ürünleri ekle
    } catch (e) {
      emit(state.copyWith(error: 'Ürünler getirilirken hata oluştu: $e'));
      print('Ürünler getirilirken hata oluştu: $e');
    }
  }

  void fetchProductsByCategory(String category) async {
    try {
      final List<Product> products = await FakeStoreService().getProductsByCategory(category);
      emit(state.copyWith(products: products));
    } catch (e) {
      emit(state.copyWith(error: 'Kategoriye göre ürünler getirilirken hata oluştu: $e'));
      print('Kategoriye göre ürünler getirilirken hata oluştu: $e');
    }
  }

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
    final bool isFavorite = state.buttonColor == Colors.black;
    final IconData iconData = isFavorite ? Icons.favorite : Icons.favorite_border;
    final Color buttonColor = isFavorite ? Colors.teal : Colors.black;
    emit(state.copyWith(buttonColor: buttonColor, iconData: iconData));
    await _saveFavoriteStatus(isFavorite);
  }

  void setSize(String size) {
    emit(state.copyWith(selectedSize: size));
  }

  Future<void> _saveFavoriteStatus(bool isFavorite) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("_favoriteKey", isFavorite);
  }

  Future<void> _loadFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isFavorite = prefs.getBool("_favoriteKey");
    if (isFavorite != null) {
      final IconData iconData = isFavorite ? Icons.favorite : Icons.favorite_border;
      final Color buttonColor = isFavorite ? Colors.teal : Colors.black;
      emit(state.copyWith(buttonColor: buttonColor, iconData: iconData));
    }
  }

  void setSelectedCategoryIndex(int index) async {
    if (index >= 0 && index < state.categories.length) {
      if (index != state.selectedCategoryIndex) {
        emit(state.copyWith(selectedCategoryIndex: index, products: []));
        try {
          final List<Product> products = await FakeStoreService().getProductsByCategory(state.categories[index]);
          emit(state.copyWith(products: products, searchedProducts: products));
        } catch (e) {
          emit(state.copyWith(error: 'Kategoriye göre ürünler getirilirken hata oluştu: $e'));
          print('Kategoriye göre ürünler getirilirken hata oluştu: $e');
        }
      }
    } else {
      emit(state.copyWith(error: 'Geçersiz kategori indeksi'));
      print('Geçersiz kategori indeksi');
    }
  }

  void setSelectedProduct(Product product) {
    emit(state.copyWith(selectedProduct: product, states: HomeStateEnum.completed));
    print('selected product: ${state.selectedProduct}');
  }

  void setAddCart(Product product) {
    // Sepette aynı üründen var mı kontrol et
    final existingIndex = state.cartItems.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      // Sepette aynı ürün varsa, ürün miktarını arttır
      final updatedCart = List<Product>.from(state.cartItems);
      updatedCart[existingIndex].quantity++; // Ürün miktarını artır
      emit(state.copyWith(cartItems: updatedCart));
    } else {
      // Sepette aynı ürün yoksa, yeni ürünü sepete ekle
      final updatedCart = List<Product>.from(state.cartItems)..add(product);
      emit(state.copyWith(cartItems: updatedCart));
    }

    // Toplam fiyatı güncelle
    updateTotalAmount();
  }

  void decreaseQuantity(Product product) {
    final updatedCart = List<Product>.from(state.cartItems);
    final index = updatedCart.indexOf(product);
    if (index != -1) {
      if (updatedCart[index].quantity > 1) {
        updatedCart[index].quantity--;
        emit(state.copyWith(cartItems: updatedCart));
        // Toplam fiyatı güncelle
        updateTotalAmount();
      }
    }
  }

  void increaseQuantity(Product product) {
    final updatedCart = List<Product>.from(state.cartItems);
    final index = updatedCart.indexOf(product);
    if (index != -1) {
      updatedCart[index].quantity++;
      emit(state.copyWith(cartItems: updatedCart));
      // Toplam fiyatı güncelle
      updateTotalAmount();
    }
  }

  void removeProductFromCart(Product product) {
    // Sepetten belirtilen ürünü kaldır
    final updatedCart = state.cartItems.where((item) => item != product).toList();
    emit(state.copyWith(cartItems: updatedCart));
    // Toplam fiyatı güncelle
    updateTotalAmount();
  }

  void resetTotalAmount() {
    emit(state.copyWith(totalAmount: 0));
  }

  void updateTotalAmount() {
    double totalAmount = 0;
    state.cartItems.forEach((product) {
      totalAmount += (product.price ?? 0) * product.quantity;
    });
    emit(state.copyWith(totalAmount: totalAmount));
  }
}
