import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
import 'package:ecommerce_with_cubit/product/widget/size_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 236, 236, 236),
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 400.w,
                            height: 400.h,
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
                                      child: SizedBox(width: 6.w), // Boşluk genişliği ayarlayabilirsiniz
                                    ),
                                    TextSpan(
                                      text: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", // Ürün adı
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(width: 12.w), // Boşluk genişliği ayarlayabilirsiniz
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
                                  const Text("| (4.5)"),
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
                                            style: TextStyle(
                                                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
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
                              text:
                                  "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 10.w),
                                Text(
                                  "295.99",
                                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                                    padding:
                                        MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                  ),
                                  child: const Text(
                                    'Sepete Ekle',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.orange),
                                    padding:
                                        MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                  ),
                                  child: const Text('Satın Al'),
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
