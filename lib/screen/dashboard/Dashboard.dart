import 'package:flutter/material.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../utils/flutter_font_style.dart';
import '../../widgets/Appbar/Appbar.dart';

class MyDashboardScreenPage extends StatefulWidget {
   MyDashboardScreenPage({super.key});
  @override
  State<MyDashboardScreenPage> createState() => _MyDashboardScreenPageState();
}
class _MyDashboardScreenPageState extends State<MyDashboardScreenPage> {

  // 1. Define a map to hold quantities for each product
  Map<int, int> _productQuantities = {};
  Set<int> _wishlistItems = {};

  // Sample product image URLs
  List<String> _productImages = [
    "https://img.freepik.com/premium-photo/illustration-turbocharger_1195898-797.jpg",
    "https://t4.ftcdn.net/jpg/01/27/89/83/360_F_127898316_hfyK1skqLfEQcz4sIolMDguRgqcFHcnp.jpg",
    "https://tiimg.tistatic.com/fp/1/008/533/car-auto-parts-for-automobile-applications-use-817.jpg",
    "https://images.pexels.com/photos/119435/pexels-photo-119435.jpeg", // fallback
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appThemes,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: AppColors.appThemes,
      //   elevation: 0,
      //   title: FittedBox(
      //     fit: BoxFit.scaleDown,
      //     child: Text(
      //       "Obsessedbycar",
      //       style: FTextStyle.sin(context)
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.notifications_none, color: Colors.white),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.favorite_border, color: Colors.white),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.person_outline, color: Colors.white),
      //     ),
      //   ],
      // ),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          // --- Search Bar Section ---
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: "Search Parts / Accessories / Brand / Part no.",
                hintStyle:  TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon:  Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:  EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // --- Hero Banner Carousel ---

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  "https://images.pexels.com/photos/119435/pexels-photo-119435.jpeg",
                  "https://images.pexels.com/photos/30889575/pexels-photo-30889575/free-photo-of-elegant-orange-sports-car-on-scenic-road.jpeg",
                  "https://images.pexels.com/photos/120049/pexels-photo-120049.jpeg",
                ].map<Widget>((item) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,

                      // ✅ SAME SIZE PLACEHOLDER (NO WHITE / NO JUMP)
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey.shade300,
                      ),

                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Text("Banner Image"),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),



          // --- Main Content Area (White Rounded Container) ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: SingleChildScrollView(
                  physics:  BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                 

                      // 1. Top Car Brands (Horizontal Scroll with 2 Rows)
                      _buildSectionHeader("TOP CAR BRANDS"),
                      _buildBrandScroll(),

                      // 2. Promotional Banners (Filters & Spares)
                      _buildPromoBanners(),

                      // 3. Search By Category (Grid)
                      _buildSectionHeader("SEARCH BY CATEGORY"),
                      _buildCategoryGrid(),

                      // 4. Product Listing (Car Accessories)
                      _buildSectionHeader("CAR ACCESSORIES"),
                      _buildProductGrid(),

                       SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget _buildBrandScroll() {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding:  EdgeInsets.symmetric(horizontal: 12),
        children: [
          _brandColumn(["Skoda", "Mahindra"]),
          _brandColumn(["Toyota", "Hyundai"]),
          _brandColumn(["Maruti Suzuki", "Tata"]),
          _brandColumn(["Honda", "Kia"]),
          _brandColumn(["Mercedes", "BMW"]),
        ],
      ),
    );
  }

  Widget _brandColumn(List<String> labels) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          _brandIcon(labels[0]),
           SizedBox(height: 16),
          _brandIcon(labels[1]),
        ],
      ),
    );
  }

  Widget _brandIcon(String label) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade100,
            child:  Icon(Icons.directions_car, color: Colors.black54), // Replace with NetworkImage/Assets
          ),
           SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style:  TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildPromoBanners() {
    return Container(
      height: 120, // Fixed height for the banner container
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3, // Number of banners
        separatorBuilder: (context, index) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          // Different images for each banner
          List<String> bannerImages = [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYQGFdqOk8GWk_Ta54Y4UNVXkcAgXyIX8dkw&s',
            'https://images.pexels.com/photos/190574/pexels-photo-190574.jpeg',
            'https://images.pexels.com/photos/119435/pexels-photo-119435.jpeg',
          ];
          
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: bannerImages[index],
              width: 200, // Fixed width for each banner
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 200,
                height: 100,
                color: Colors.grey.shade300,
                child: Icon(Icons.image, color: Colors.grey.shade500),
              ),
              errorWidget: (context, url, error) => Container(
                width: 200,
                height: 100,
                color: Colors.grey.shade300,
                child: Icon(Icons.error, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = ["Maintenance", "Belts", "Body", "Brake System", "AC", "Bearings", "Cables", "Accessories"];
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding:  EdgeInsets.symmetric(horizontal: 12),
        itemCount: (categories.length / 2).ceil(),
        itemBuilder: (context, index) => Container(
          width: 80,
          margin:  EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // First row item
              if (index * 2 < categories.length)
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade100,
                      child:  Icon(Icons.category, color: Colors.black87),
                    ),
                     SizedBox(height: 4),
                    Text(categories[index * 2], textAlign: TextAlign.center, style:  TextStyle(fontSize: 10)),
                  ],
                ),
              // Second row item
              if (index * 2 + 1 < categories.length)
                Column(
                  children: [
                     SizedBox(height: 4),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade100,
                      child:  Icon(Icons.category, color: Colors.black87),
                    ),
                     SizedBox(height: 4),
                    Text(categories[index * 2 + 1], textAlign: TextAlign.center, style:  TextStyle(fontSize: 10)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      padding:  EdgeInsets.all(16),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _productCard(index),
    );
  }



// 2. Updated _productCard widget
  Widget _productCard(int index) {
    // Initialize quantity for this product if not already set
    if (!_productQuantities.containsKey(index)) {
      _productQuantities[index] = 0;
    }
    
    int currentQuantity = _productQuantities[index] ?? 0;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: _productImages[index % _productImages.length],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image, size: 50, color: Colors.grey.shade600),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image, size: 50, color: Colors.grey.shade600),
                    ),
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (_wishlistItems.contains(index)) {
                            _wishlistItems.remove(index);
                          } else {
                            _wishlistItems.add(index);
                          }
                        });
                      },
                      child: Icon(
                        _wishlistItems.contains(index) 
                          ? Icons.favorite 
                          : Icons.favorite_border,
                        size: 20,
                        color: _wishlistItems.contains(index) 
                          ? Colors.red 
                          : Colors.grey.shade600,
                      ),
                    ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // OEM Label
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                      "OEM",
                      style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                    "Car Interior Dust Brush",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)
                ),
                const SizedBox(height: 4),
                const Text("₹130/-", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                Row(
                  children: [
                    const Text(
                        "₹150/-",
                        style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 10)
                    ),
                    const Spacer(),

                    // --- QUANTITY LOGIC START ---
                    currentQuantity == 0
                        ? InkWell(
                      onTap: () {
                        setState(() {
                          _productQuantities[index] = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red.shade100),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          // Minus Button
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (currentQuantity > 0) {
                                  _productQuantities[index] = currentQuantity - 1;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              child: const Icon(Icons.remove, size: 16, color: Colors.black),
                            ),
                          ),
                          // Quantity Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                                "$currentQuantity",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                            ),
                          ),
                          // Plus Button
                          InkWell(
                            onTap: () {
                              setState(() {
                                _productQuantities[index] = currentQuantity + 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: const Icon(Icons.add, size: 16, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // --- QUANTITY LOGIC END ---
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}