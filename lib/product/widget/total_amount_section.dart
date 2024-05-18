import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';

class TotalAmountSection extends StatelessWidget {
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Ödeme yapma işlemi
              },
              child: const Text('Ödeme Yap'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
