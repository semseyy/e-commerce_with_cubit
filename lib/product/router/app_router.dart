import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/view/home_view.dart';
import 'package:ecommerce_with_cubit/product/view/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'product_detail',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => HomeCubit(),
              child: const ProductDetailPage(),
            );
          },
        ),
      ],
    ),
  ],
);
