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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              maxRadius: 26,
              backgroundColor: navyColor,
              child: Image.asset(
                'assets/images/Logo.png',
                width: 35,
                height: 35,
              ),
            ),
            Text(
              'İCEMİLLA',
              style: GoogleFonts.pacifico(
                fontSize: 22.sp,
                color: blackColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.push("/checkout", extra: context.read<HomeCubit>());
                  },
                  icon: Icon(Icons.shopping_cart, color: tealColor),
                );
              },
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
                  hintText: 'Search...',
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
                if (state.productImages.isEmpty) {
                  return const Text("Görüntü yok");
                } else {
                  final List<String> adjustedImages = state.productImages.map((image) {
                    // İndeksleri 1'den başlayacak şekilde ayarlayın
                    return image;
                  }).toList();

                  return ImageCarouselSlider(images: adjustedImages);
                }
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
                          print("Selected category: $selectedCategory");
                          print("Selected index: $index");
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
