import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/flutter_color_themes.dart';
import '../../widgets/Appbar/Appbar.dart';
import '../searchCategory/SearchCategory.dart';
import '../dashboard/Bloc/Slider/slider_bloc.dart';
import 'bloc/getspares/getspares_bloc.dart';
import 'model/category_model.dart';


class MySparesScreenPage extends StatefulWidget {
   MySparesScreenPage({super.key});

  @override
  State<MySparesScreenPage> createState() => _MySparesScreenPageState();
}

class _MySparesScreenPageState extends State<MySparesScreenPage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SliderBloc()..add(FetchSliderEvent()),
        ),
        BlocProvider(
          create: (context) => GetsparesBloc()..add(FetchCategoryEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.appThemes,
        appBar:  CustomAppBar(),
        body: Column(
          children: [
            /// 🔍 SEARCH BAR
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12),
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
                ),
              ),
            ),

            /// 🎯 BANNER CAROUSEL
            BlocBuilder<SliderBloc, SliderState>(
              builder: (context, state) {
                if (state is SliderLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else if (state is SliderError) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
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
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text("No slider images available"),
                        ),
                      ),
                    );
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          /// 🔹 CAROUSEL
                          CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 180,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() => _currentIndex = index);
                              },
                            ),
                            items: sliderImages.map<Widget>((item) {
                              return CachedNetworkImage(
                                imageUrl: item,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  color: Colors.grey.shade300,
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  color: Colors.grey.shade200,
                                  alignment: Alignment.center,
                                  child: const Text("Banner Image"),
                                ),
                              );
                            }).toList(),
                          ),

                          /// 🔹 DOT INDICATOR (ON IMAGE)
                          Positioned(
                            bottom: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(sliderImages.length, (index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  width: _currentIndex == index ? 10 : 8,
                                  height: _currentIndex == index ? 10 : 8,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Initial state - show loading
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              },
            ),


          /// 📦 MAIN CONTENT
          Expanded(
            child: Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.vertical(
                //   top: Radius.circular(30),
                // ),
              ),
              child: SingleChildScrollView(
                physics:  BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("SEARCH BY CATEGORY"),
                    _buildCategoryGrid(),
                     SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  /// 🔠 SECTION TITLE
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Text(
        title,
        style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  /// 📊 CATEGORY GRID (NO SCROLL)
  Widget _buildCategoryGrid() {
    return BlocBuilder<GetsparesBloc, GetsparesState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else if (state is CategoryLoaded) {
          final categories = state.categories;
          if (categories.isEmpty) {
            return const Center(child: Text("No categories available"));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final CategoryModel category = categories[index];
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
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: CachedNetworkImageProvider(category.image),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
