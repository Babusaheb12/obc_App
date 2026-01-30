import 'package:flutter/material.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/flutter_font_style.dart';
import '../../widgets/Appbar/Appbar.dart';

class MyAccessoriesScreenPage extends StatefulWidget {
  MyAccessoriesScreenPage({super.key});

  @override
  State<MyAccessoriesScreenPage> createState() =>
      _MyAccessoriesScreenPageState();
}

class _MyAccessoriesScreenPageState extends State<MyAccessoriesScreenPage> {
  Map<int, int> _productQuantities = {};
  Set<int> _wishlistItems = {};

  // Sample product image URLs
  final List<String> _productImages = [
    "https://img.freepik.com/premium-photo/illustration-turbocharger_1195898-797.jpg",
    "https://t4.ftcdn.net/jpg/01/27/89/83/360_F_127898316_hfyK1skqLfEQcz4sIolMDguRgqcFHcnp.jpg",
    "https://tiimg.tistatic.com/fp/1/008/533/car-auto-parts-for-automobile-applications-use-817.jpg",
    "https://images.pexels.com/photos/119435/pexels-photo-119435.jpeg",
    "https://www.shutterstock.com/image-photo/automotive-parts-spark-plug-air-600nw-2160765299.jpg",

    // fallback
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
      //     child: Text("Obsessedbycar", style: FTextStyle.sin(context)),
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
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          SizedBox(height: 5),
          // --- Main Content Area (White Rounded Container) ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Top Car Brands (Horizontal Scroll with 2 Rows)
                      _buildFilterBar(),

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
  Set<int> _selectedIndices = {}; // Track selected filter indices

  Widget _buildFilterBar() {
    final filters = ["BRAND", "MODEL", "PRICE", "CATEGORY"];

    return Container(
      color: Colors.white, // 👈 yaha background color change karo
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: filters.map((title) {
              int index = filters.indexOf(title);
              bool isSelected = _selectedIndices.contains(index);
              
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedIndices.contains(index)) {
                        _selectedIndices.remove(index); // Deselect if already selected
                      } else {
                        _selectedIndices.add(index); // Select if not already selected
                      }
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.appThemes // Selected color
                          : Colors.white, // Unselected color
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.appThemes // Selected border color
                            : Colors.grey.shade300, // Unselected border color
                      ),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected 
                            ? Colors.white // Selected text color
                            : Colors.black87, // Unselected text color
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }


  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemCount: 11,
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
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey.shade600,
                      ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "OEM",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Car Interior Dust Brush",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  "₹130/-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                Row(
                  children: [
                    const Text(
                      "₹150/-",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 10,
                      ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red.shade100),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                        _productQuantities[index] =
                                            currentQuantity - 1;
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
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // Quantity Text
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    "$currentQuantity",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                // Plus Button
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _productQuantities[index] =
                                          currentQuantity + 1;
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
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.red,
                                    ),
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
