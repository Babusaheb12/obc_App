import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/flutter_color_themes.dart';
import '../../widgets/Appbar/Appbar.dart';

class MySparesScreenPage extends StatefulWidget {
  const MySparesScreenPage({super.key});

  @override
  State<MySparesScreenPage> createState() => _MySparesScreenPageState();
}

class _MySparesScreenPageState extends State<MySparesScreenPage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appThemes,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          /// 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: "Search Parts / Accessories / Brand / Part no.",
                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 🎯 BANNER CAROUSEL
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  /// 🔹 CAROUSEL
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() => _currentIndex = index);
                      },
                    ),
                    items: [
                      "https://images.pexels.com/photos/119435/pexels-photo-119435.jpeg",
                      "https://images.pexels.com/photos/30889575/pexels-photo-30889575/free-photo-of-elegant-orange-sports-car-on-scenic-road.jpeg",
                      "https://images.pexels.com/photos/120049/pexels-photo-120049.jpeg",
                    ].map<Widget>((item) {
                      return CachedNetworkImage(
                        imageUrl: item,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: Colors.grey.shade300,
                        ),
                        errorWidget: (_, __, ___) => const Center(
                          child: Text("Banner Image"),
                        ),
                      );
                    }).toList(),
                  ),

                  /// 🔹 DOT INDICATOR (ON IMAGE)
                  Positioned(
                    bottom: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 10 : 8,
                          height: _currentIndex == index ? 10 : 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),


          /// 📦 MAIN CONTENT
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.vertical(
                //   top: Radius.circular(30),
                // ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("SEARCH BY CATEGORY"),
                    _buildCategoryGrid(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔠 SECTION TITLE
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  /// 📊 CATEGORY GRID (NO SCROLL)
  Widget _buildCategoryGrid() {
    final categories = [
      "Maintenance",
      "Belts",
      "Body",
      "Brake System",
      "AC",
      "Bearings",
      "Cables",
      "Accessories",
      "Maintenance",
      "Belts",
      "Body",
      "Brake System",
      "AC",
      "Bearings",
      "Cables",
      "Accessories",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade100,
                child: const Icon(Icons.category),
              ),
              const SizedBox(height: 6),
              Text(
                categories[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
