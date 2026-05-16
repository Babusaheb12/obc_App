import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/Appbar/Appbar.dart';
import '../productDetails/productDetails.dart';
import 'Bloc/Slider/slider_bloc.dart';
import 'Bloc/CarBrands/car_brands_bloc.dart';
import '../Spares/bloc/getspares/getspares_bloc.dart';
import '../Spares/model/category_model.dart';
import '../searchCategory/SearchCategory.dart';
import 'CarModelScreen.dart';
import 'Bloc/carAccessories/car_accessories_bloc.dart';
import '../Accessories/AccessoriesDetails.dart';


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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SliderBloc()..add(FetchSliderEvent())),
        BlocProvider(create: (context) => CarBrandsBloc()..add(FetchCarBrandsEvent())),
        BlocProvider(create: (context) => GetsparesBloc()..add(FetchCategoryEvent())),
        BlocProvider(create: (context) => CarAccessoriesBloc()..add(FetchCarAccessoriesEvent())),
      ],
      child: Scaffold(
        backgroundColor: AppColors.appThemes,
        appBar:  CustomAppBar(),
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
            BlocBuilder<SliderBloc, SliderState>(
              builder: (context, state) {
                if (state is SliderLoading) {
                  return Padding(
                    padding:  EdgeInsets.all(12.0),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else if (state is SliderError) {
                  return Padding(
                    padding:  EdgeInsets.all(12.0),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(state.message),
                      ),
                    ),
                  );
                } else if (state is SliderLoaded) {
                  List<String> sliderImages = state.sliderImages;
                  if (sliderImages.isEmpty) {
                    return Padding(
                      padding:  EdgeInsets.all(12.0),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  Center(
                          child: Text("No slider images available"),
                        ),
                      ),
                    );
                  }
                    
                  return Padding(
                    padding:  EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 180,
                          autoPlay: true,
                          autoPlayInterval:  Duration(seconds: 3),
                          autoPlayAnimationDuration:  Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          viewportFraction: 1.0,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: sliderImages.map<Widget>((item) {
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
                                child:  Text("Banner Image"),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                } else {
                  // Initial state - show loading or default images
                  return Padding(
                    padding:  EdgeInsets.all(12.0),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              },
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
                        // SizedBox(height: 20),

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

  // Widget _buildBrandScroll() {
  //   return BlocBuilder<CarBrandsBloc, CarBrandsState>(
  //     builder: (context, state) {
  //       if (state is CarBrandsLoading) {
  //         return SizedBox(
  //           height: 125, // pehle 200 tha
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       } else if (state is CarBrandsError) {
  //         return SizedBox(
  //           height: 200,
  //           child: Center(
  //             child: Text(
  //               state.message,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(color: Colors.grey),
  //             ),
  //           ),
  //         );
  //       } else if (state is CarBrandsLoaded) {
  //         List<CarBrand> brands = state.brands;
  //         if (brands.isEmpty) {
  //           return SizedBox(
  //             height: 200,
  //             child: Center(
  //               child: Text(
  //                 'No car brands available',
  //                 style: TextStyle(color: Colors.grey),
  //               ),
  //             ),
  //           );
  //         }
  //
  //         // Group brands into pairs for the 2-row layout
  //         List<List<CarBrand>> brandPairs = [];
  //         for (int i = 0; i < brands.length; i += 2) {
  //           int end = i + 2;
  //           if (end <= brands.length) {
  //             brandPairs.add(brands.sublist(i, end));
  //           } else {
  //             brandPairs.add(brands.sublist(i));
  //           }
  //         }
  //         return SizedBox(
  //           height: 200,
  //           child: ListView(
  //             scrollDirection: Axis.horizontal,
  //             padding: EdgeInsets.symmetric(horizontal: 12),
  //             children: brandPairs.map((pair) => _brandColumnFromApi(pair)).toList(),
  //           ),
  //         );
  //       } else {
  //         // Initial state
  //         return SizedBox(
  //           height: 100,
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
  //
  // Widget _brandColumnFromApi(List<CarBrand> brands) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 8),
  //     child: Column(
  //       children: [
  //         if (brands.length > 0) _brandIconFromApi(brands[0]),
  //         if (brands.length > 1) ...[
  //           SizedBox(height: 16),
  //           _brandIconFromApi(brands[1]),
  //         ],
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _brandIconFromApi(CarBrand brand) {
  //   return SizedBox(
  //     width: 80,
  //     child: Column(
  //       children: [
  //         Container(
  //           width: 34,
  //           height: 34,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Colors.grey.shade100,
  //           ),
  //           child: ClipOval(
  //             child: CachedNetworkImage(
  //               imageUrl: brand.imageUrl,
  //               fit: BoxFit.contain,
  //               placeholder: (context, url) => Icon(
  //                 Icons.directions_car,
  //                 color: Colors.grey,
  //                 size: 30,
  //               ),
  //               errorWidget: (context, url, error) => Icon(
  //                 Icons.directions_car,
  //                 color: Colors.grey,
  //                 size: 30,
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 6),
  //         Text(
  //           brand.name,
  //           textAlign: TextAlign.center,
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(fontSize: 11),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildPromoBanners() {
  //   return BlocBuilder<SliderBloc, SliderState>(
  //     builder: (context, state) {
  //       List<String> offerImages = [];
  //
  //       if (state is SliderLoaded) {
  //         offerImages = state.offerImages;
  //       }
  //
  //       // If no offers available, return empty container
  //       if (offerImages.isEmpty) {
  //         return Container(
  //           height: 120,
  //           padding: EdgeInsets.symmetric(vertical: 10),
  //           child: Center(
  //             child: Text(
  //               'No offers available',
  //               style: TextStyle(
  //                 color: Colors.grey,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //
  //       return Container(
  //         height: 120, // Fixed height for the banner container
  //         padding: EdgeInsets.symmetric(vertical: 10),
  //         child: ListView.separated(
  //           scrollDirection: Axis.horizontal,
  //           padding: EdgeInsets.symmetric(horizontal: 16),
  //           itemCount: offerImages.length,
  //           separatorBuilder: (context, index) => SizedBox(width: 12),
  //           itemBuilder: (context, index) {
  //             return ClipRRect(
  //               borderRadius: BorderRadius.circular(12),
  //               child: CachedNetworkImage(
  //                 imageUrl: offerImages[index],
  //                 width: 200, // Fixed width for each banner
  //                 height: 100,
  //                 fit: BoxFit.cover,
  //                 placeholder: (context, url) => Container(
  //                   width: 200,
  //                   height: 100,
  //                   color: Colors.grey.shade300,
  //                   child: Icon(Icons.image, color: Colors.grey.shade500),
  //                 ),
  //                 errorWidget: (context, url, error) => Container(
  //                   width: 200,
  //                   height: 100,
  //                   color: Colors.grey.shade300,
  //                   child: Icon(Icons.error, color: Colors.red),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }


  Widget _buildBrandScroll() {
    return BlocBuilder<CarBrandsBloc, CarBrandsState>(
      builder: (context, state) {
        if (state is CarBrandsLoading) {
          return  SizedBox(
            height: 140,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CarBrandsError) {
          return SizedBox(
            height: 140,
            child: Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style:  TextStyle(color: Colors.grey),
              ),
            ),
          );
        } else if (state is CarBrandsLoaded) {
          List<CarBrand> brands = state.brands;

          if (brands.isEmpty) {
            return  SizedBox(
              height: 140,
              child: Center(
                child: Text(
                  'No car brands available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }

          // Group brands into pairs
          List<List<CarBrand>> brandPairs = [];

          for (int i = 0; i < brands.length; i += 2) {
            int end = i + 2;

            if (end <= brands.length) {
              brandPairs.add(brands.sublist(i, end));
            } else {
              brandPairs.add(brands.sublist(i));
            }
          }

          return SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:  EdgeInsets.symmetric(horizontal: 12),
              children: brandPairs
                  .map((pair) => _brandColumnFromApi(pair))
                  .toList(),
            ),
          );
        }

        return  SizedBox(
          height: 140,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _brandColumnFromApi(List<CarBrand> brands) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (brands.isNotEmpty) _brandIconFromApi(brands[0]),

          if (brands.length > 1) ...[
             SizedBox(height: 6),
            _brandIconFromApi(brands[1]),
          ],
        ],
      ),
    );
  }

  Widget _brandIconFromApi(CarBrand brand) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarModelScreen(
              carMakerId: brand.id,
              carMakerName: brand.name,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              width: 66,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: brand.imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>  Icon(
                    Icons.directions_car,
                    color: Colors.grey,
                    size: 18,
                  ),
                  errorWidget: (context, url, error) =>  Icon(
                    Icons.directions_car,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            ),

             SizedBox(height: 2),

            Text(
              brand.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanners() {
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        List<String> offerImages = [];

        if (state is SliderLoaded) {
          offerImages = state.offerImages;
        }

        if (offerImages.isEmpty) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            child:  Text(
              'No offers available',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          );
        }

        return Container(
          height: 100,
          padding:  EdgeInsets.only(top: 0, bottom: 4),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding:  EdgeInsets.symmetric(horizontal: 16),
            itemCount: offerImages.length,
            separatorBuilder: (context, index) =>
             SizedBox(width: 10),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: offerImages[index],
                  width: 180,
                  height: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 180,
                    height: 90,
                    color: Colors.grey.shade300,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 180,
                    height: 90,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child:  Icon(Icons.error, color: Colors.red),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  Widget _buildCategoryGrid() {
    return BlocBuilder<GetsparesBloc, GetsparesState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return  SizedBox(
            height: 190,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoryError) {
          return SizedBox(
            height: 170,
            child: Center(child: Text(state.message)),
          );
        } else if (state is CategoryLoaded) {
          final categories = state.categories;
          if (categories.isEmpty) {
            return  SizedBox(
              height: 190,
              child: Center(child: Text("No categories available")),
            );
          }
          return SizedBox(
            height: 190,
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
                      _buildCategoryItem(context, categories[index * 2]),
                    // Second row item
                    if (index * 2 + 1 < categories.length)
                      _buildCategoryItem(context, categories[index * 2 + 1]),
                  ],
                ),
              ),
            ),
          );
        }
        return  SizedBox.shrink();
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MySearchCategoryScreen(initialCategoryId: category.id),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 66,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: category.image,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) =>
                 Icon(Icons.category, color: Colors.black87, size: 20),
              ),
            ),
          ),
           SizedBox(height: 4),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style:  TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return BlocBuilder<CarAccessoriesBloc, CarAccessoriesState>(
      builder: (context, state) {
        if (state is CarAccessoriesLoading) {
          return  Center(child: CircularProgressIndicator());
        } else if (state is CarAccessoriesError) {
          return Center(child: Text(state.message));
        } else if (state is CarAccessoriesLoaded) {
          final accessories = state.accessories.where((a) => a.featured == 'Yes').toList();
          if (accessories.isEmpty) {
            return  Center(child: Text('No featured accessories found'));
          }
          return GridView.builder(
            shrinkWrap: true,
            physics:   NeverScrollableScrollPhysics(),
            padding:   EdgeInsets.all(16),
            gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.50,
            ),
            itemCount: accessories.length,
            itemBuilder: (context, index) => _productCard(accessories[index], index),
          );
        }
        return  SizedBox.shrink();
      },
    );
  }



// 2. Updated _productCard widget
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
            MaterialPageRoute(builder: (context) => MyAccessoriesDetails(productId: int.tryParse(accessory.id) ?? 0)),
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
            padding:  EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Origin Label
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                      accessory.origin.isNotEmpty ? accessory.origin : "OEM",
                      style:  TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)
                  ),
                ),
                 SizedBox(height: 4),
                Text(
                    accessory.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w600)
                ),
                 SizedBox(height: 2),
                Text(
                    accessory.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600)
                ),
                 SizedBox(height: 4),
                Text("₹${accessory.sellingPrice}/-", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                Row(
                  children: [
                    Text(
                        "₹${accessory.price}/-",
                        style:  TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 10)
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
                        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red.shade100),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child:  Text(
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
                              padding:  EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              child:  Icon(Icons.remove, size: 16, color: Colors.black),
                            ),
                          ),
                          // Quantity Text
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                                "$currentQuantity",
                                style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
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
                              padding:  EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius:  BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child:  Icon(Icons.add, size: 16, color: Colors.red),
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