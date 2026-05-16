import 'package:flutter/material.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dashboard/Bloc/carAccessories/car_accessories_bloc.dart';

import '../../widgets/Appbar/Appbar.dart';
import '../productDetails/productDetails.dart';
import 'AccessoriesDetails.dart';

class MyAccessoriesScreenPage extends StatefulWidget {
  MyAccessoriesScreenPage({super.key});

  @override
  State<MyAccessoriesScreenPage> createState() =>
      _MyAccessoriesScreenPageState();
}

class _MyAccessoriesScreenPageState extends State<MyAccessoriesScreenPage> {
  Map<int, int> _productQuantities = {};
  Set<int> _wishlistItems = {};



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarAccessoriesBloc()..add(FetchCarAccessoriesEvent()),
      child: Scaffold(
        backgroundColor: AppColors.appThemes,
        appBar:  const CustomAppBar(),
        body: Column(
          children: [
            // --- Search Bar Section ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // --- Main Content Area (White Rounded Container) ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterBar(),
                        _buildProductGrid(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Set<int> _selectedIndices = {}; // Track selected filter indices

  Widget _buildFilterBar() {
    final filters = ["BRAND", "MODEL", "PRICE", "CATEGORY"];

    return Container(
      color: Colors.white, // 👈 yaha background color change karo
      padding:  EdgeInsets.symmetric(vertical: 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics:  BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: filters.map((title) {
              int index = filters.indexOf(title);
              bool isSelected = _selectedIndices.contains(index);
              
              return Padding(
                padding:  EdgeInsets.only(right: 10),
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
                     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    return BlocBuilder<CarAccessoriesBloc, CarAccessoriesState>(
      builder: (context, state) {
        if (state is CarAccessoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarAccessoriesError) {
          return Center(child: Text(state.message));
        } else if (state is CarAccessoriesLoaded) {
          final accessories = state.accessories; // SHOW ALL DATA
          if (accessories.isEmpty) {
            return const Center(child: Text('No accessories found'));
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.65, // Match dashboard aspect ratio
            ),
            itemCount: accessories.length,
            itemBuilder: (context, index) => _productCard(accessories[index], index),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _productCard(CarAccessory accessory, int index) {
    // Initialize quantity for this product if not already set
    if (!_productQuantities.containsKey(index)) {
      _productQuantities[index] = 0;
    }

    int currentQuantity = _productQuantities[index] ?? 0;

    return GestureDetector(
        onTap: () {
          // Navigate to product details page with product ID
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyAccessoriesDetails(
                productId: int.tryParse(accessory.id) ?? 0,
              ),
            ),
          );
        },
        child: Container(
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
                    imageUrl: accessory.image,
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
            padding:  EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Origin Label
                Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child:  Text(
                    accessory.origin.isNotEmpty ? accessory.origin : "OEM",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                 SizedBox(height: 4),
                 Text(
                  accessory.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                 SizedBox(height: 2),
                 Text(
                  accessory.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                 SizedBox(height: 4),
                 Text(
                  "₹${accessory.sellingPrice}/-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                Row(
                  children: [
                     Text(
                      "₹${accessory.price}/-",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                     Spacer(),

                    // --- QUANTITY LOGIC START ---
                    currentQuantity == 0
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                _productQuantities[index] = 1;
                              });
                            },
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red.shade100),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child:  Text(
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
                                    padding:  EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius:  BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                    child:  Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // Quantity Text
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    "$currentQuantity",
                                    style:  TextStyle(
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
                                    padding:  EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius:  BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                    child:  Icon(
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
          ),
    );
  }
}
