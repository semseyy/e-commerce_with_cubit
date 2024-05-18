import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                'İCEMİLLA',
                style: GoogleFonts.pacifico(
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
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
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ImageCarouselSlider(images: urlImages);
              },
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return CategoryWidget(
                    categories: state.categories,
                    selectedIndex: state.selectedCategoryIndex,
                    onCategorySelected: (index) {
                      if (index == state.selectedCategoryIndex) {
                        // Clear selection if the same category is tapped again
                        context.read<HomeCubit>().setSelectedCategoryIndex(-1);
                      } else {
                        final selectedCategory = index != -1 ? state.categories[index] : "Tüm Kategoriler";
                        context.read<HomeCubit>().fetchProductsByCategory(selectedCategory);
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final filteredProducts = state.selectedCategoryIndex != -1
                        ? state.products.where((product) => product.category == state.selectedCategoryIndex).toList()
                        : state.products;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.80,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductItem(
                            productName: product.name,
                            productImage: NetworkImage(product.imageUrl),
                            productId: product.id,
                            onTap: () {
                              context.read<HomeCubit>().setSelectedProduct(product);
                              context.push('/product_detail', extra: context.read<HomeCubit>());
                            },
                          );
                        },
                      ),
                    );
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
