import 'package:flutter/material.dart';

import '../../widgets/Appbar/productDetailsAppbar.dart';

class MySearchCategoryScreen extends StatefulWidget {
  const MySearchCategoryScreen({super.key});

  @override
  State<MySearchCategoryScreen> createState() => _MySearchCategoryScreenState();
}

class _MySearchCategoryScreenState extends State<MySearchCategoryScreen> {
  int _selectedSidebarIndex = 0;

  // Sidebar Items
  final List<String> _sidebarCategories = [
    "Maintainance Service Parts",
    "Air Conditioning",
    "Belts Chains and Rollers",
    "Bearings",
    "Body",
    "Control Cables",
    "Brake System",
  ];

  // Grid Items for the selected category
  final List<Map<String, String>> _gridItems = [
    {"name": "Belt", "image": "https://via.placeholder.com/100"},
    {"name": "Brake", "image": "https://via.placeholder.com/100"},
    {"name": "Clutch", "image": "https://via.placeholder.com/100"},
    {"name": "Engine Oil", "image": "https://via.placeholder.com/100"},
    {"name": "Filter", "image": "https://via.placeholder.com/100"},
    {"name": "Glow Plug", "image": "https://via.placeholder.com/100"},
    {"name": "Horn", "image": "https://via.placeholder.com/100"},
    {"name": "Lights", "image": "https://via.placeholder.com/100"},
    {"name": "Service Kit", "image": "https://via.placeholder.com/100"},
    {"name": "Spark Plug", "image": "https://via.placeholder.com/100"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProductDetailsAppBar(
        title: 'Category', // dynamically set the title
        automaticallyImplyLeading: true, // if you want the back button
      ),
      body: Row(
        children: [
          // --- Left Sidebar Navigation ---
          Container(
            width: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
            ),
            child: ListView.builder(
              itemCount: _sidebarCategories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedSidebarIndex == index;
                return InkWell(
                  onTap: () => setState(() => _selectedSidebarIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red.shade50 : Colors.transparent,
                      border: isSelected
                          ? const Border(left: BorderSide(color: Colors.red, width: 4))
                          : null,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade100,
                          child: Icon(Icons.settings, color: isSelected ? Colors.red : Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _sidebarCategories[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.red : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Right Content Grid ---
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              itemCount: _gridItems.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          _gridItems[index]['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _gridItems[index]['name']!,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}