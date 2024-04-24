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

  const HomeState({
    required this.states,
    required this.activeIndex,
    required this.buttonColor,
    required this.iconData,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        states,
        activeIndex,
        buttonColor,
        iconData,
      ];

  factory HomeState.initial() => const HomeState(
        states: HomeStates.initial,
        activeIndex: 0,
        buttonColor: Colors.black,
        iconData: Icons.favorite_border,
      );

  HomeState copyWith({
    HomeStates? states,
    int? activeIndex,
    Color? buttonColor,
    IconData? iconData,
  }) {
    return HomeState(
      states: states ?? this.states,
      activeIndex: activeIndex ?? this.activeIndex,
      buttonColor: buttonColor ?? this.buttonColor,
      iconData: iconData ?? this.iconData,
    );
  }
}
