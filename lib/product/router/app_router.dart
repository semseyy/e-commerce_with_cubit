import 'package:ecommerce_with_cubit/feature/home/view/home_view.dart';
import 'package:ecommerce_with_cubit/product/view/product_detail.dart';
import 'package:flutter/material.dart';
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
            return ProductDetailPage();
          },
        ),
      ],
    ),
  ],
);
