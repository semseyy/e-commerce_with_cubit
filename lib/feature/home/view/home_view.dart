import 'package:carousel_slider/carousel_controller.dart';
import 'package:ecommerce_with_cubit/feature/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
import 'package:ecommerce_with_cubit/feature/home/model/home_model.dart';
import 'package:ecommerce_with_cubit/feature/home/widget/carousel_slider_widget.dart';
import 'package:ecommerce_with_cubit/feature/home/widget/category_widget.dart';
import 'package:ecommerce_with_cubit/feature/home/widget/product_widget.dart';
import 'package:ecommerce_with_cubit/feature/home/widget/subtitle_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CarouselController _carouselController = CarouselController();
  final List<String> urlImages = [
    "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs7-performance-motion-front-2-1669663936.jpg?crop=0.673xw:0.757xh;0.287xw,0.226xh&resize=768:*",
    "https://hips.hearstapps.com/hmg-prod/images/img-1484-jpg-649644d3c1386.jpg?crop=0.571xw:0.762xh;0.240xw,0.195xh&resize=640:*",
    "https://www.cnet.com/a/img/resize/e8c8dd2963e629687fbcfe8d68ce37804114da62/hub/2020/11/06/fe337281-ae20-4ad4-997b-95c2937b9258/ogi1-2021-audi-rs7-008.jpg?auto=webp&fit=crop&height=675&width=1200"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'İCEMİLLA',
              style: GoogleFonts.pacifico(
                fontSize: 30.sp,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ara...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ImageCarouselSlider(images: urlImages),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return CategoryWidget(
                    categories: state.categories,
                    selectedIndex: state.selectedCategoryIndex,
                    onCategorySelected: (index) {
                      context.read<HomeCubit>().setSelectedCategoryIndex(index);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: FakeStoreService().getProducts(), // Fetch products from API
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // Products fetched successfully
                    final products = snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.80,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductItem(
                            productName: product.name,
                            productImage: NetworkImage(product.imageUrl),
                            onTap: () {
                              context.go('/product_detail');
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return subtitle(subtitles: state.subtitles, currentSubtitleIndex: state.currentSubtitleIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
