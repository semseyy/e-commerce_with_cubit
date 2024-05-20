import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/view/home_view.dart';
import 'package:ecommerce_with_cubit/feature/splash/splash_view.dart';
import 'package:ecommerce_with_cubit/product/view/checkout_view.dart';
import 'package:ecommerce_with_cubit/product/view/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => HomeCubit(),
          child: const SplashPage(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => HomeCubit(),
              child: const HomeView(),
            );
          },
        ),
        GoRoute(
          path: 'product_detail',
          builder: (BuildContext context, GoRouterState state) {
            // productId'i alın
            return BlocProvider.value(
              value: state.extra as HomeCubit,
              child: const ProductDetailPage(),
            );
          },
        ),
        GoRoute(
          path: 'checkout',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider.value(
              value: state.extra as HomeCubit,
              child: const CheckoutPage(),
            );
          },
        ),
      ],
    ),
  ],
);
