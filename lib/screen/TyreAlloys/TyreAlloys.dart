import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/Appbar/Appbar.dart';

class MyTyreAlloysScreenPage extends StatefulWidget {
   MyTyreAlloysScreenPage({super.key});

  @override
  State<MyTyreAlloysScreenPage> createState() => _MyTyreAlloysScreenPageState();
}

class _MyTyreAlloysScreenPageState extends State<MyTyreAlloysScreenPage> {
  final String tyreImageUrl =
      "https://bombaytyres.com/cdn/shop/files/D22A7078copy.jpg?v=1706364951&width=1946";
  final String alloyImageUrl =
      "https://img.freepik.com/free-psd/sleek-black-alloy-wheel-3d-render-modern-car-rim_191095-85663.jpg";

  final Set<int> _wishlistItems = {};
  final Map<int, int> _productQuantities = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  CustomAppBar(),
        body: Column(
          children: [
            // ===== Search + Tabs (OUTSIDE APPBAR) =====
            Container(
              color:  Color(0xFF001B48),
              child: Column(
                children: [
                  Padding(
                    // padding:  EdgeInsets.fromLTRB(16, 12, 16, 12),
                    padding:  EdgeInsets.all(4),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText:
                        "Search Accessories / Parts / Brand / Part no.",
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                  Container(
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.vertical(
                      //   top: Radius.circular(20),
                      // ),
                    ),
                    child:  TabBar(
                      indicatorColor: Color(0xFF001B48),
                      indicatorWeight: 3,
                      labelColor: Color(0xFF001B48),
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

            // ===== TAB CONTENT =====
            Expanded(
              child: TabBarView(
                children: [
                  _buildProductGrid(tyreImageUrl, "Bridgestone Tyre"),
                  _buildProductGrid(alloyImageUrl, "Black Alloy Rim"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= PRODUCT GRID =================
  Widget _buildProductGrid(String imageUrl, String name) {
    return GridView.builder(
      padding:  EdgeInsets.all(12),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        int uniqueIndex =
        imageUrl == tyreImageUrl ? index : index + 100;
        return _buildProductCard(imageUrl, name, uniqueIndex);
      },
    );
  }

  // ================= PRODUCT CARD =================
  Widget _buildProductCard(
      String imageUrl, String name, int uniqueIndex) {
    _productQuantities.putIfAbsent(uniqueIndex, () => 0);
    int qty = _productQuantities[uniqueIndex]!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _wishlistItems.contains(uniqueIndex)
                            ? _wishlistItems.remove(uniqueIndex)
                            : _wishlistItems.add(uniqueIndex);
                      });
                    },
                    child: Icon(
                      _wishlistItems.contains(uniqueIndex)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _wishlistItems.contains(uniqueIndex)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.all(8),
            child: Text(
              name,
              style:
               TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
