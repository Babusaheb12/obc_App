import 'package:flutter/material.dart';

class MyPreownedCarScreenPage extends StatefulWidget {
  const MyPreownedCarScreenPage({super.key});

  @override
  State<MyPreownedCarScreenPage> createState() => _MyPreownedCarScreenPageState();
}

class _MyPreownedCarScreenPageState extends State<MyPreownedCarScreenPage> {
  // Mock data for the filters shown in the screenshot
  final List<String> filters = ["BRAND", "PRICE", "YEAR", "FUEL TYPE"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF001B48), // Dark Blue Brand Color
        elevation: 0,
        title: const Text(
          "Obsessedbycar",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline, color: Colors.white)),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Car Brand / Model / Make",
                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // --- Filter Horizontal List ---
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      filters[index],
                      style: const TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Car Listings ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 6, // Number of items based on Screenshot 8
              itemBuilder: (context, index) {
                return _buildCarCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Image
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Image.network(
              "https://images.pexels.com/photos/119435/pexels-photo-119435.jpeg", // Hyundai i20 Placeholder
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Car Details Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hyundai i20 - DIESEL",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Text("i20 2015 model", style: TextStyle(color: Colors.black54, fontSize: 13)),
                const Text("2015 - 100000 km", style: TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 4),
                const Text(
                  "₹4,00,000/-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("Jaipur", style: TextStyle(color: Colors.grey, fontSize: 12)),
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