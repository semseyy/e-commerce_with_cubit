import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSize = ''; // Seçili bedenin durumunu tutmak için bir değişken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                    Row(
                      children: [
                        Text(
                          "Satıcı Adı",
                          style: TextStyle(fontSize: 20.sp, color: Colors.blue),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "Ürün Adı",
                          style: TextStyle(fontSize: 20.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      height: 180.h,
                      width: 395.w,
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
                                    Icon(Icons.error, size: 20.sp),
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
                      width: 395.w,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 395.w, // Container genişliğini artırıyoruz
                          color: Colors.grey.shade600,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "295.99",
                                style: TextStyle(fontSize: 18.sp, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
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
                              ElevatedButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.orange),
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                ),
                                child: const Text('Satın Al'),
                              ),
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
              child: IconButton(
                onPressed: () {
                  // Favoriler butonuna basıldığında yapılacak işlemler
                },
                icon: Icon(Icons.favorite_border), // Favoriler butonu
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
