import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
import 'package:ecommerce_with_cubit/product/consdant/color_consdant.dart';
import 'package:ecommerce_with_cubit/product/widget/size_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final product = state.selectedProduct;
        return Scaffold(
          backgroundColor: whiteColor,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(product?.imageUrl ?? ""),
                              fit: BoxFit.contain,
                            ),
                          ),
                          width: 400.w,
                          height: 420.h,
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "icemilla ",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: blueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: SizedBox(width: 6.w),
                                  ),
                                  TextSpan(
                                    text: product?.name ?? "",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: blackColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(width: 12.w),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  if (index < product!.rating!.floor()) {
                                    return Icon(
                                      Icons.star,
                                      color: amberColor,
                                      size: 20.sp,
                                    );
                                  } else if (index < product.rating!.toDouble()) {
                                    return Icon(
                                      Icons.star_half,
                                      color: amberColor,
                                      size: 20.sp,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.star_border,
                                      color: amberColor,
                                      size: 20.sp,
                                    );
                                  }
                                }),
                                SizedBox(width: 10.w),
                                Text("| ${product!.rating!.toStringAsFixed(1)} "),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Divider(height: 1.h, color: blackColor)
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Beden",
                                          style: TextStyle(
                                              color: blackColor, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                    const Text("Beden Seçenekleri"),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    SizeOption(size: "XS"),
                                    SizeOption(size: "S"),
                                    SizeOption(size: "M"),
                                    SizeOption(size: "L"),
                                    SizeOption(size: "XL"),
                                    SizeOption(size: "2XL"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(height: 1.h, color: blackColor),
                        SizedBox(height: 10.h),
                        Text.rich(
                          TextSpan(
                            text: product.description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: blackColor,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const Spacer(),
                        Container(
                          color: lightGreyColor,
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              Text(
                                "\$ ${product.price.toString()}",
                                style: TextStyle(fontSize: 18.sp, color: blackColor),
                              ),
                              const Spacer(),
                              BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  if (state.showSnackBar) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(state.snackBarMessage),
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: tealColor,
                                        ),
                                      );
                                      context.read<HomeCubit>().hideSnackBar();
                                    });
                                  }
                                  return ElevatedButton(
                                    onPressed: () {
                                      context.read<HomeCubit>().setAddCart(product);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(whiteColor),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)),
                                    ),
                                    child: Text(
                                      'Sepete Ekle',
                                      style: TextStyle(color: tealColor),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 10.w),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<HomeCubit>().setBuyCart(product);
                                  context.push("/checkout", extra: context.read<HomeCubit>());
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(tealColor),
                                  padding:
                                      MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)),
                                ),
                                child: const Text('Satın Al'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: lightGreyColor,
                    child: IconButton(
                      icon: Icon(
                        state.iconData,
                        color: state.buttonColor,
                      ),
                      onPressed: () {
                        context.read<HomeCubit>().addFavorite();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: lightGreyColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: blackColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
