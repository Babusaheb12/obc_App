import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/Appbar/Appbar.dart';
import '../productDetails/productDetails.dart';

class MyTyreAlloysScreenPage extends StatefulWidget {
  const MyTyreAlloysScreenPage({super.key});

  @override
  State<MyTyreAlloysScreenPage> createState() => _MyTyreAlloysScreenPageState();
}

class _MyTyreAlloysScreenPageState extends State<MyTyreAlloysScreenPage> {
  final String tyreImageUrl = "https://bombaytyres.com/cdn/shop/files/D22A7078copy.jpg?v=1706364951&width=1946";
  final String alloyImageUrl = "https://img.freepik.com/free-psd/sleek-black-alloy-wheel-3d-render-modern-car-rim_191095-85663.jpg";

  final Set<int> _wishlistItems = {};
  final Map<int, int> _productQuantities = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100], 
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Container(
              color: const Color(0xFF001B48),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Search Accessories / Parts / Brand / Part no.",
                          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const TabBar(
                      indicatorColor: Color(0xFF001B48),
                      indicatorWeight: 3,
                      labelColor: Color(0xFF001B48),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Tyre"),
                        Tab(text: "Alloy"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProductGrid(tyreImageUrl, "hello"),
                  _buildProductGrid(alloyImageUrl, "Alloy Rim"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(String imageUrl, String name) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72, // Adjusted for the badges and buttons
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        int uniqueIndex = imageUrl == tyreImageUrl ? index : index + 100;
        return _buildProductCard(imageUrl, name, uniqueIndex);
      },
    );
  }

  Widget _buildProductCard(String imageUrl, String name, int uniqueIndex) {
    int qty = _productQuantities[uniqueIndex] ?? 0;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyProductDetailsPage(productId: uniqueIndex)),
          );
        },
        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Wishlist
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () => setState(() {
                      _wishlistItems.contains(uniqueIndex) ? _wishlistItems.remove(uniqueIndex) : _wishlistItems.add(uniqueIndex);
                    }),
                    child: Icon(
                      _wishlistItems.contains(uniqueIndex) ? Icons.favorite : Icons.favorite_border,
                      color: _wishlistItems.contains(uniqueIndex) ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const Text("hello", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),

                // Badges Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(color: Colors.lightGreenAccent.shade100, borderRadius: BorderRadius.circular(4)),
                      child: const Text("M R F", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFF001B48), borderRadius: BorderRadius.circular(4)),
                      child: const Row(
                        children: [
                          Icon(Icons.directions_car, color: Colors.white, size: 10),
                          SizedBox(width: 2),
                          Text("OBC Approved", style: TextStyle(fontSize: 8, color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Price and Add Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("₹1,300/-", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("₹1,300/-", style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                    qty == 0
                        ? SizedBox(
                      height: 30,
                      width: 70,
                      child: OutlinedButton(
                        onPressed: () => setState(() => _productQuantities[uniqueIndex] = 1),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text("Add", style: TextStyle(color: Colors.red)),
                      ),
                    )
                        : Container(
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          _qtyBtn(Icons.remove, () => setState(() => _productQuantities[uniqueIndex] = qty - 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          _qtyBtn(Icons.add, () => setState(() => _productQuantities[uniqueIndex] = qty + 1)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
        ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        color: Colors.grey.shade200,
        child: Icon(icon, size: 16),
      ),
    );
  }
}