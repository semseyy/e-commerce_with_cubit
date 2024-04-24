import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSize = ''; // Seçili bedenin durumunu tutmak için bir değişken
  Color buttonColor = Colors.black;
  IconData iconData = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/audi.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 400.w,
                      height: 400.h,
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          Text(
                            "Satıcı Adı",
                            style: TextStyle(fontSize: 20.sp, color: Colors.blue),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            "Ürün Adı",
                            style: TextStyle(fontSize: 20.sp, color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      height: 180.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Renk",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(Icons.error_outline, size: 20.sp, color: Colors.grey.shade400),
                                  ],
                                ),
                                const Text("15 Farklı Renk"),
                              ],
                            ),
                          ),
                          Divider(height: 1.h, color: Colors.black),
                          SizedBox(height: 8.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                  SizedBox(width: 4.w),
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                  SizedBox(width: 4.w),
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                  SizedBox(width: 4.w),
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                  SizedBox(width: 4.w),
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                  SizedBox(width: 4.w),
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                  SizedBox(width: 4.w),
                                  Image.asset("assets/images/audi.jpg", width: 100.w, height: 120.h, fit: BoxFit.cover),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      height: 100.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Beden",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(Icons.error, size: 20.sp),
                                  ],
                                ),
                                const Text("Beden Seçenekleri"),
                              ],
                            ),
                          ),
                          Divider(height: 1.h, color: Colors.black),
                          SizedBox(height: 8.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  buildSizeOption("S"),
                                  SizedBox(width: 4.w),
                                  buildSizeOption("M"),
                                  SizedBox(width: 4.w),
                                  buildSizeOption("L"),
                                  SizedBox(width: 4.w),
                                  buildSizeOption("XL"),
                                  SizedBox(width: 4.w),
                                  buildSizeOption("2XL"),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Stack(
                      children: [
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
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
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
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                ),
                                child: const Text('Satın Al'),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                      ],
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
                  onPressed: () {
                    setState(() {
                      if (buttonColor == Colors.black) {
                        buttonColor = Colors.orange;
                        iconData = Icons.favorite;
                      } else {
                        buttonColor = Colors.black;
                        iconData = Icons.favorite_border;
                      }
                    });
                  },
                  icon: Icon(iconData),
                  color: buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizeOption(String size) {
    // Beden seçeneğini inşa etmek için bir Widget
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size; // Seçili bedeni güncelle
        });
      },
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
              color:
                  selectedSize == size ? Colors.orange : Colors.black), // Seçili beden ise mavi, değilse siyah kenarlık
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: selectedSize == size ? Colors.orange : Colors.black, // Seçili beden ise mavi, değilse siyah renk
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
