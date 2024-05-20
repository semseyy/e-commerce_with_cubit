import 'package:ecommerce_with_cubit/product/consdant/color_consdant.dart';
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

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 26,
              backgroundColor: navyColor,
              child: Image.asset(
                'assets/images/Logo.png',
                width: 35.w,
                height: 35.h,
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                'İCEMİLLA',
                style: GoogleFonts.pacifico(
                  fontSize: 22.sp,
                  color: blackColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
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
            SizedBox(height: 8.h),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ImageCarouselSlider(images: state.productImages);
              },
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
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
              ],
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
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
