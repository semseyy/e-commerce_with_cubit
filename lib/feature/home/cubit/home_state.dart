import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum HomeStates {
  initial,
  loading,
  completed,
  error,
}

class HomeState extends Equatable {
  final HomeStates states;
  final int activeIndex;
  final Color buttonColor;
  final IconData iconData;
  final String selectedSize;
  final List<String> subtitles;
  final int currentSubtitleIndex;
  final bool isSelected;
  final List<String> categories;
  final int selectedCategoryIndex;

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
  });

  @override
  // TODO: implement props
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
      ];

  factory HomeState.initial() => const HomeState(
      states: HomeStates.initial,
      activeIndex: 0,
      buttonColor: Colors.black,
      iconData: Icons.favorite_border,
      selectedSize: "",
      subtitles: [
        "Tüm ürünlerde %20 indirim",
        "Pantolonlarda 2 alana 1 bedava",
        "Tüm ürünlerde sepette ek %15 indirim"
      ],
      currentSubtitleIndex: 0,
      isSelected: false,
      selectedCategoryIndex: -1,
      categories: ["electronics", "jewelery", "men's clothing", "women's clothing"]);

  HomeState copyWith({
    HomeStates? states,
    int? activeIndex,
    Color? buttonColor,
    IconData? iconData,
    String? selectedSize,
    List<String>? subtitles,
    int? currentSubtitleIndex,
    bool? isSelected,
    List<String>? categories,
    int? selectedCategoryIndex,
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
    );
  }
}
