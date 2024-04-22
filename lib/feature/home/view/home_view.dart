import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class Product {
  final String name;
  final AssetImage image;
  Product({required this.name, required this.image});
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeIndex = 0;
  final CarouselController _carouselController = CarouselController();
  final List<Product> products = [
    Product(
      name: 'Ürün 1',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 2',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 3',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 4',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 5',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 6',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 7',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    Product(
      name: 'Ürün 8',
      image: AssetImage("assets/images/audi.jpg"),
    ),
    // Dilediğiniz kadar ürün ekleyebilirsiniz
  ];

  final urlImages = [
    "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs7-performance-motion-front-2-1669663936.jpg?crop=0.673xw:0.757xh;0.287xw,0.226xh&resize=768:*",
    "https://hips.hearstapps.com/hmg-prod/images/img-1484-jpg-649644d3c1386.jpg?crop=0.571xw:0.762xh;0.240xw,0.195xh&resize=640:*",
    "https://www.cnet.com/a/img/resize/e8c8dd2963e629687fbcfe8d68ce37804114da62/hub/2020/11/06/fe337281-ae20-4ad4-997b-95c2937b9258/ogi1-2021-audi-rs7-008.jpg?auto=webp&fit=crop&height=675&width=1200"
  ];

  final categories = ["Araba", "Kıyafet", "Ayakkabı", "Araba", "Kıyafet", "Ayakkabı"]; // List of categories
  List<bool> isSelected = List.generate(6, (index) => false); // Initial selection states

  late Timer _timer;
  int _currentSubtitleIndex = 0;
  final List<String> _subtitles = [
    "Tüm ürünlerde %20 indirim",
    "Pantolonlarda 2 alana 1 bedava",
    "Subtitle 3",
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentSubtitleIndex = (_currentSubtitleIndex + 1) % _subtitles.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'İCEMİLLA',
                style: GoogleFonts.pacifico(
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ara...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
                  height: 200.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (index, reason) => setState(() => activeIndex = index),
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 12.h),
              buildIndicator(),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => buildCategoryBox(categories[index], index),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Grid'de kaç ürün olacağı
                      crossAxisSpacing: 8.0, // Yatayda aralık
                      mainAxisSpacing: 8.0, // Dikeyde aralık
                      childAspectRatio: 0.80, // Genişlik / Yükseklik oranı
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return buildProductItem(products[index]);
                    },
                  ),
                ),
              ),
              subtitle(subtitles: _subtitles, currentSubtitleIndex: _currentSubtitleIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: ExpandingDotsEffect(
          dotHeight: 10.h,
          dotWidth: 10.w,
          activeDotColor: Colors.limeAccent,
        ),
      );

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.network(
            urlImage,
            width: double.infinity,
            height: 200.h, // İstediğiniz yüksekliği burada belirleyebilirsiniz
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildCategoryBox(String category, int index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: GestureDetector(
          onTap: () {
            setState(() {
              // Clear all selections
              isSelected = List.generate(categories.length, (i) => false);
              // Toggle current selection
              isSelected[index] = !isSelected[index];
            });
          },
          child: Container(
            child: Text(
              category,
              style: TextStyle(
                color: isSelected[index] ? Colors.black : Colors.white,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isSelected[index] ? Colors.orange : Colors.grey,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      );

  Widget buildProductItem(Product product) => GridTile(
        child: GestureDetector(
          onTap: () {
            context.push("/product_detail");
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image(
                image: product.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(product.name),
        ),
      );
}

class subtitle extends StatelessWidget {
  const subtitle({
    super.key,
    required List<String> subtitles,
    required int currentSubtitleIndex,
  })  : _subtitles = subtitles,
        _currentSubtitleIndex = currentSubtitleIndex;

  final List<String> _subtitles;
  final int _currentSubtitleIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade600,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        _subtitles[_currentSubtitleIndex],
        style: TextStyle(fontSize: 18.sp, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
