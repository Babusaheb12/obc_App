import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'bloc/preowned_car_bloc.dart';
import 'PreownedCarDetails.dart';

class MyPreownedCarScreenPage extends StatefulWidget {
   MyPreownedCarScreenPage({super.key});

  @override
  State<MyPreownedCarScreenPage> createState() => _MyPreownedCarScreenPageState();
}

class _MyPreownedCarScreenPageState extends State<MyPreownedCarScreenPage> {
  // Mock data for the filters shown in the screenshot
  final List<String> filters = ["BRAND", "PRICE", "YEAR", "FUEL TYPE"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreownedCarBloc()..add(FetchPreownedCarsEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:  const Color(0xFF001B48), // Dark Blue Brand Color
          elevation: 0,
          title:  const Text(
            "Obsessedbycar",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(onPressed: () {}, icon:  const Icon(Icons.notifications_none, color: Colors.white)),
            IconButton(onPressed: () {}, icon:  const Icon(Icons.favorite_border, color: Colors.white)),
            IconButton(onPressed: () {}, icon:  const Icon(Icons.shopping_cart_outlined, color: Colors.white)),
            IconButton(onPressed: () {}, icon:  const Icon(Icons.person_outline, color: Colors.white)),
          ],
          bottom: PreferredSize(
            preferredSize:  const Size.fromHeight(70),
            child: Padding(
              padding:  const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search Car Brand / Model / Make",
                  hintStyle:  const TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon:  const Icon(Icons.search, color: Colors.grey),
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
              padding:  const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:  const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:  const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        filters[index],
                        style:  const TextStyle(color: Colors.black87, fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- Car Listings ---
            Expanded(
              child: BlocBuilder<PreownedCarBloc, PreownedCarState>(
                builder: (context, state) {
                  if (state is PreownedCarLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PreownedCarError) {
                    return Center(child: Text(state.message));
                  } else if (state is PreownedCarLoaded) {
                    final cars = state.cars;
                    if (cars.isEmpty) {
                      return const Center(child: Text('No preowned cars found'));
                    }
                    return ListView.builder(
                      padding:  const EdgeInsets.all(16),
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        return _buildCarCard(cars[index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarCard(PreownedCarItem car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreownedCarDetailsScreen(car: car),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
              borderRadius:  const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: car.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: car.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
            ),
  
            // Car Details Section
            Padding(
              padding:  const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "${car.brand} ${car.model} - ${car.variant}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                   Text(car.title, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                   Text("${car.year} - ${car.km} km", style: const TextStyle(color: Colors.black54, fontSize: 13)),
                   const SizedBox(height: 4),
                   Text(
                    "₹${car.price}/-",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF001B48)),
                  ),
                   const SizedBox(height: 4),
                  Row(
                    children:  [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(car.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
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