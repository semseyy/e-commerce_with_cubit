import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
import 'package:ecommerce_with_cubit/product/consdant/color_consdant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TotalAmountSection extends StatelessWidget {
  const TotalAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        double totalAmount = 0;
        // Sepetteki her ürünün fiyatını ve miktarını toplam fiyata ekleyin
        for (var product in state.cartItems) {
          totalAmount += (product.price ?? 0) * product.quantity;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Toplam: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Alert göster
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Ödeme Tamamlandı"),
                      content: const Text("Ödemeniz başarıyla tamamlandı!"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Tamam"),
                          onPressed: () {
                            context.push("/home");
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: whiteColor,
                backgroundColor: tealColor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                textStyle: TextStyle(fontSize: 16.sp),
              ),
              child: const Text('Ödeme Yap'),
            ),
          ],
        );
      },
    );
  }
}
