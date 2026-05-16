
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/Appbar/productDetailsAppbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/tyre_details_bloc.dart';


class MytyreAlloysDetails extends StatefulWidget {
  final int productId;

  MytyreAlloysDetails({super.key, required this.productId});

  @override
  State<MytyreAlloysDetails> createState() => _MytyreAlloysDetailsState();
}

class _MytyreAlloysDetailsState extends State<MytyreAlloysDetails> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TyreDetailsBloc()..add(FetchTyreDetailsEvent(widget.productId.toString())),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ProductDetailsAppBar(
          title: 'Product Details', // dynamically set the title
          automaticallyImplyLeading: true, // if you want the back button
        ),
        body: BlocBuilder<TyreDetailsBloc, TyreDetailsState>(
          builder: (context, state) {
            if (state is TyreDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TyreDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is TyreDetailsLoaded) {
              final data = state.data;
              
              // Extract data with fallbacks
              final String name = data['tyre_title'] ?? data['tyre_brand'] ?? 'N/A';
              final String brand = data['tyre_brand'] ?? 'N/A';
              final String price = data['tyre_price'] ?? '0'; // Discounted price
              final String originalPrice = data['tyre_sellingprice'] ?? '0'; // MRP
              final String description = data['tyre_description'] ?? data['tyre_title'] ?? 'No description available.';
              final String image = data['tyre_image'] ?? '';
              
              // Calculate discount percentage
              double p = double.tryParse(price) ?? 0;
              double op = double.tryParse(originalPrice) ?? 0;
              int discountPercent = 0;
              if (op > p && op > 0) {
                discountPercent = (((op - p) / op) * 100).round();
              }

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100), // Space for bottom buttons
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Image Carousel ---
                        _buildImageCarousel(image),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- Title ---
                              Text(
                                name,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF001B48)),
                              ),
                              const SizedBox(height: 8),

                              // --- Brand & Origin ---
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("by $brand", style: const TextStyle(color: Colors.blue, fontSize: 16)),
                                  Text(data['tyre_origin'] ?? 'Origen OEM', style: const TextStyle(color: Colors.blue, fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // --- Ratings ---
                              Row(
                                children: [
                                  ...List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange, size: 20)),
                                  const SizedBox(width: 8),
                                  const Text("(0 reviews)", style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // --- Price & Discount ---
                              Row(
                                children: [
                                  Text("₹$price", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  if (op > p)
                                    Text("₹$originalPrice", style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 16)),
                                  const SizedBox(width: 15),
                                  if (discountPercent > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(4)),
                                      child: Text("$discountPercent% OFF", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // --- Stock Status ---
                              const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green, size: 24),
                                  SizedBox(width: 8),
                                  Text("In Stock", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // --- Quantity Selector ---
                              const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 10),
                              _buildQuantitySelector(),

                              const SizedBox(height: 24),
                              const Divider(),

                              // --- Description ---
                              const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 10),
                              Text(
                                description,
                                style: const TextStyle(color: Colors.grey, height: 1.5, fontSize: 16),
                              ),

                              const SizedBox(height: 24),

                              // --- Specifications ---
                              const Text("Specifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 10),
                              _buildSpecRow("Brand", brand),
                              _buildSpecRow("Model", data['tyre_partnumber'] ?? 'N/A'),
                              _buildSpecRow("Delivery", data['tyre_delivery'] ?? 'N/A'),
                              _buildSpecRow("Car Maker", "Universal"),
                              _buildSpecRow("Width", data['width'] ?? 'N/A'),
                              _buildSpecRow("Height", data['height'] ?? 'N/A'),
                              _buildSpecRow("Rim Diameter", data['rim_diameter'] ?? 'N/A'),
                              _buildSpecRow("Wheel Type", data['tyre_wheel'] ?? 'N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- Bottom Action Buttons ---
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildBottomActions(),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
  Widget _buildImageCarousel(String imageUrl) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.only(top: 2), // small space from AppBar
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                  height: 250,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  height: 250,
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              )
            : Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
      ),
    );
  }
  Widget _buildQuantitySelector() {
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => setState(() => _quantity > 1 ? _quantity-- : null),
            icon: Icon(Icons.remove, size: 20),
          ),
          Text("$_quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () => setState(() => _quantity++),
            icon: Icon(Icons.add, size: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Color(0xFF001B48), fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF001B48),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF001B48),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Buy now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}