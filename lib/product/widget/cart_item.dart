import 'package:ecommerce_with_cubit/product/consdant/color_consdant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/model/home_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartItem({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    return Card(
      margin: EdgeInsets.all(10.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '\$${(product.price! * quantity).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.sp, color: greenColor),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity == 1) {
                      // Ürün miktarı 1 ise sepetten kaldırma işlemi
                      cubit.removeProductFromCart(product);
                    } else {
                      // Ürün miktarını azaltma işlemi
                      cubit.decreaseQuantity(product);
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 16.sp),
                ),
                IconButton(
                  onPressed: () {
                    cubit.increaseQuantity(product);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
