import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
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
          backgroundColor: const Color.fromARGB(255, 236, 236, 236),
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
                              fit: BoxFit.cover,
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
                                  color: Colors.blue,
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
                                      color: Colors.black,
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
                                Icon(Icons.star, color: Colors.amber, size: 20.sp),
                                Icon(Icons.star, color: Colors.amber, size: 20.sp),
                                Icon(Icons.star, color: Colors.amber, size: 20.sp),
                                Icon(Icons.star, color: Colors.amber, size: 20.sp),
                                Icon(Icons.star, color: Colors.amber, size: 20.sp),
                                SizedBox(width: 10.w),
                                const Text("| (5.0)"),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Divider(height: 1.h, color: Colors.black)
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
                                      children: const [
                                        Text(
                                          "Beden",
                                          style:
                                              TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
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
                        Divider(height: 1.h, color: Colors.black),
                        SizedBox(height: 10.h),
                        Text.rich(
                          TextSpan(
                            text: product?.description ?? "",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const Spacer(),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              Text(
                                product?.price.toString() ?? "",
                                style: TextStyle(fontSize: 18.sp, color: Colors.black),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<HomeCubit>().setAddCart(product!);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  padding:
                                      MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)),
                                ),
                                child: const Text(
                                  'Sepete Ekle',
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              ElevatedButton(
                                onPressed: () {
                                  context.push("/checkout", extra: context.read<HomeCubit>());
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.teal),
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
                    backgroundColor: Colors.white,
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
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
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
