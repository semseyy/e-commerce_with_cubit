import 'package:ecommerce_with_cubit/feature/home/model/home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum HomeStateEnum {
  initial,
  loading,
  completed,
  error,
}

class HomeState extends Equatable {
  final HomeStateEnum states;
  final int activeIndex;
  final Color buttonColor;
  final IconData iconData;
  final String selectedSize;
  final List<String> subtitles;
  final int currentSubtitleIndex;
  final bool isSelected;
  final List<String> categories;
  final int selectedCategoryIndex;
  final List<Product> products;
  final List<Product> filteredProducts;
  final List<Product> searchedProducts;
  final Product? selectedProduct;
  final List<Product> productModel;
  final String error;
  final double totalAmount;
  final String couponCode;
  final double discount;
  final List<int> quantities;
  final List<Product> cart;
  final List<String> productImages;
  final List<Product> cartItems;
  final int quantity;
  final bool showSnackBar;
  final String snackBarMessage;

  const HomeState({
    required this.states,
    required this.activeIndex,
    required this.buttonColor,
    required this.iconData,
    required this.selectedSize,
    required this.subtitles,
    required this.currentSubtitleIndex,
    required this.isSelected,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.products,
    required this.filteredProducts,
    required this.searchedProducts,
    this.selectedProduct,
    required this.productModel,
    required this.error,
    required this.totalAmount,
    required this.couponCode,
    required this.discount,
    required this.quantities,
    required this.cart,
    required this.productImages,
    required this.cartItems,
    required this.quantity,
    required this.showSnackBar,
    required this.snackBarMessage,
  });

  @override
  List<Object?> get props => [
        states,
        activeIndex,
        buttonColor,
        iconData,
        selectedSize,
        subtitles,
        currentSubtitleIndex,
        isSelected,
        categories,
        selectedCategoryIndex,
        products,
        filteredProducts,
        searchedProducts,
        selectedProduct,
        productModel,
        error,
        totalAmount,
        couponCode,
        discount,
        quantities,
        cart,
        productImages,
        cartItems,
        quantity,
        showSnackBar,
        snackBarMessage,
      ];

  factory HomeState.initial() => const HomeState(
        states: HomeStateEnum.initial,
        activeIndex: 0,
        buttonColor: Colors.black,
        iconData: Icons.favorite_border,
        selectedSize: "",
        subtitles: [
          "20% discount on all products.",
          "Buy 2 pants, get 1 free.",
          "Additional 15% discount in the cart for all products."
        ],
        currentSubtitleIndex: 0,
        isSelected: false,
        selectedCategoryIndex: -1,
        categories: ["electronics", "jewelery", "men's clothing", "women's clothing"],
        products: [],
        filteredProducts: [],
        searchedProducts: [],
        selectedProduct: null,
        productModel: [],
        error: '',
        totalAmount: 0,
        couponCode: '',
        discount: 0,
        quantities: [],
        cart: [],
        productImages: [],
        cartItems: [],
        quantity: 1,
        showSnackBar: false,
        snackBarMessage: '',
      );

  HomeState copyWith({
    HomeStateEnum? states,
    int? activeIndex,
    Color? buttonColor,
    IconData? iconData,
    String? selectedSize,
    List<String>? subtitles,
    int? currentSubtitleIndex,
    bool? isSelected,
    List<String>? categories,
    int? selectedCategoryIndex,
    List<Product>? products,
    List<Product>? filteredProducts,
    List<Product>? searchedProducts,
    Product? selectedProduct,
    List<Product>? productModel,
    String? error,
    double? totalAmount,
    String? couponCode,
    double? discount,
    List<int>? quantities,
    List<Product>? cart,
    List<String>? productImages,
    List<Product>? cartItems,
    int? quantity,
    bool? showSnackBar,
    String? snackBarMessage,
  }) {
    return HomeState(
      states: states ?? this.states,
      activeIndex: activeIndex ?? this.activeIndex,
      buttonColor: buttonColor ?? this.buttonColor,
      iconData: iconData ?? this.iconData,
      selectedSize: selectedSize ?? this.selectedSize,
      subtitles: subtitles ?? this.subtitles,
      currentSubtitleIndex: currentSubtitleIndex ?? this.currentSubtitleIndex,
      isSelected: isSelected ?? this.isSelected,
      categories: categories ?? this.categories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchedProducts: searchedProducts ?? this.searchedProducts,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      productModel: productModel ?? this.productModel,
      error: error ?? this.error,
      totalAmount: totalAmount ?? this.totalAmount,
      couponCode: couponCode ?? this.couponCode,
      discount: discount ?? this.discount,
      quantities: quantities ?? this.quantities,
      cart: cart ?? this.cart,
      productImages: productImages ?? this.productImages,
      cartItems: cartItems ?? this.cartItems,
      quantity: quantity ?? this.quantity,
      showSnackBar: showSnackBar ?? this.showSnackBar,
      snackBarMessage: snackBarMessage ?? this.snackBarMessage,
    );
  }
}
