import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/Appbar/productDetailsAppbar.dart';


class MyProductDetailsPage extends StatefulWidget {
  final int productId;

  MyProductDetailsPage({super.key, required this.productId});

  @override
  State<MyProductDetailsPage> createState() => _MyProductDetailsPageState();
}

class _MyProductDetailsPageState extends State<MyProductDetailsPage> {
  int _currentImageIndex = 0;
  int _quantity = 1;

  // Sample product data - in a real app this would come from an API or database
  final List<Map<String, dynamic>> _products = [
    {
      'id': 0,
      'name': 'Car Interior Dust Brush',
      'brand': 'AutoCare',
      'origin': 'OEM',
      'price': 130,
      'originalPrice': 150,
      'discount': 20,
      'rating': 4.5,
      'reviews': 0,
      'stockStatus': 'In Stock',
      'description': 'High-quality car interior dust brush for cleaning hard-to-reach areas.',
      'specifications': {
        'Brand': 'AutoCare',
        'Model': 'DUST-2023',
        'Delivery': '3 Days',
        'Car Maker': 'Universal',
      },
      'images': [
        'https://media.istockphoto.com/id/1800033825/photo/hand-cleaning-the-car-interior-with-microfiber-cloth-towel.jpg?s=612x612&w=0&k=20&c=bz4YG60xCvOifo0jz1BbThdW0lA1hWS9I85o-Wdxj0A=',
        'https://www.aquaprovac.com/cdn/shop/articles/7.png?v=1755024675',
      ],
    },
    {
      'id': 1,
      'name': 'Turbo Charger for Sedan',
      'brand': 'TurboMax',
      'origin': 'Origen OEM',
      'price': 15000,
      'originalPrice': 18000,
      'discount': 17,
      'rating': 4.8,
      'reviews': 15,
      'stockStatus': 'In Stock',
      'description': 'High-performance turbo charger for improved engine efficiency.',
      'specifications': {
        'Brand': 'TurboMax',
        'Model': 'TC-500',
        'Delivery': '5 Days',
        'Car Maker': 'Various',
      },
      'images': [
        'https://img.freepik.com/premium-photo/illustration-turbocharger_1195898-797.jpg',
        'https://www.aquaprovac.com/cdn/shop/articles/7.png?v=1755024675',
      ],
    },
    {
      'id': 2,
      'name': 'Car Brake Pads Set',
      'brand': 'BrakePro',
      'origin': 'Origen OEM',
      'price': 2500,
      'originalPrice': 3000,
      'discount': 17,
      'rating': 4.3,
      'reviews': 8,
      'stockStatus': 'In Stock',
      'description': 'Premium quality brake pads for enhanced stopping power and durability.',
      'specifications': {
        'Brand': 'BrakePro',
        'Model': 'BP-S100',
        'Delivery': '2 Days',
        'Car Maker': 'Universal',
      },
      'images': [
        'https://t4.ftcdn.net/jpg/01/27/89/83/360_F_127898316_hfyK1skqLfEQcz4sIolMDguRgqcFHcnp.jpg',
        'https://www.aquaprovac.com/cdn/shop/articles/7.png?v=1755024675',
      ],
    },
    {
      'id': 3,
      'name': 'Engine Oil Filter',
      'brand': 'FilterPlus',
      'origin': 'Origen OEM',
      'price': 450,
      'originalPrice': 550,
      'discount': 18,
      'rating': 4.2,
      'reviews': 12,
      'stockStatus': 'In Stock',
      'description': 'High-efficiency engine oil filter for optimal engine protection.',
      'specifications': {
        'Brand': 'FilterPlus',
        'Model': 'EOF-2023',
        'Delivery': '1 Day',
        'Car Maker': 'Universal',
      },
      'images': [
        'https://tiimg.tistatic.com/fp/1/008/533/car-auto-parts-for-automobile-applications-use-817.jpg',
        'https://www.aquaprovac.com/cdn/shop/articles/7.png?v=1755024675',
      ],
    },
  ];

  Map<String, dynamic>? get _currentProduct {
    return _products.firstWhere((product) => product['id'] == widget.productId, orElse: () => _products[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar:  ProductDetailsAppBar(),
      appBar: ProductDetailsAppBar(
        title: 'Product Details', // dynamically set the title
        automaticallyImplyLeading: true, // if you want the back button
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100), // Space for bottom buttons
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Image Carousel ---
                _buildImageCarousel(),

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Title ---
                      Text(
                        _currentProduct!['name'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF001B48)),
                      ),
                      SizedBox(height: 8),

                      // --- Brand & Origin ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("by ${_currentProduct!['brand']}", style: TextStyle(color: Colors.blue)),
                          Text(_currentProduct!['origin'], style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                      SizedBox(height: 8),

                      // --- Ratings ---
                      Row(
                        children: [
                          ...List.generate(
                            _currentProduct!['rating'].floor(),
                            (index) => Icon(Icons.star, color: Colors.orange, size: 20),
                          ),
                          if (_currentProduct!['rating'] % 1 != 0)
                            Icon(Icons.star_half, color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Text("(${_currentProduct!['reviews']} reviews)", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 12),

                      // --- Price & Discount ---
                      Row(
                        children: [
                          Text("₹${_currentProduct!['price']}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Text("₹${_currentProduct!['originalPrice']}", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                          SizedBox(width: 15),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(4)),
                            child: Text("${_currentProduct!['discount']}% OFF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // --- Stock Status ---
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: _currentProduct!['stockStatus'] == 'In Stock' ? Colors.green : Colors.red),
                          SizedBox(width: 8),
                          Text(_currentProduct!['stockStatus'], style: TextStyle(color: _currentProduct!['stockStatus'] == 'In Stock' ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 20),

                      // --- Quantity Selector ---
                      Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 10),
                      _buildQuantitySelector(),

                      SizedBox(height: 24),
                      Divider(),

                      // --- Description ---
                      Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 10),
                      Text(
                        _currentProduct!['description'],
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),

                      SizedBox(height: 24),

                      // --- Specifications ---
                      Text("Specifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 10),
                      ..._currentProduct!['specifications'].entries.map<Widget>((MapEntry entry) {
                        return _buildSpecRow(entry.key, entry.value);
                      }).toList(),
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
      ),
    );
  }
  Widget _buildImageCarousel() {
    return SafeArea(
      top: false,
      child: Container(
        margin: EdgeInsets.only(top: 2), // small space from AppBar
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) => setState(() => _currentImageIndex = index),
              ),
              items: _currentProduct!['images'].map<Widget>((String url) {
                return CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
            ),
            Positioned(
              bottom: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_currentProduct!['images'].length, (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == index ? Colors.white : Colors.grey.shade400,
                    ),
                  );
                }),
              ),
            ),
          ],
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