import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';
import 'package:ecommerce_with_cubit/product/widget/cart_item.dart';
import 'package:ecommerce_with_cubit/product/widget/total_amount_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cartItems = state.cartItems;
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return CartItem(
                product: product,
                quantity: product.quantity,
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sepet toplamı
            TotalAmountSection(),
          ],
        ),
      ),
    );
  }
}
