import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/Appbar/productDetailsAppbar.dart';
import 'bloc/search_category_bloc.dart';
import '../Spares/model/category_model.dart';
import 'model/sub_category_model.dart';

class MySearchCategoryScreen extends StatefulWidget {
  final String? initialCategoryId;

  const MySearchCategoryScreen({super.key, this.initialCategoryId});

  @override
  State<MySearchCategoryScreen> createState() => _MySearchCategoryScreenState();
}

class _MySearchCategoryScreenState extends State<MySearchCategoryScreen> {
  late SearchCategoryBloc _bloc;
  int _selectedSidebarIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc = SearchCategoryBloc()..add(FetchCategoriesEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ProductDetailsAppBar(
          title: 'Category',
          automaticallyImplyLeading: true,
        ),
        body: BlocListener<SearchCategoryBloc, SearchCategoryState>(
          listener: (context, state) {
            // Fetch subcategories for the first category or passed category when categories are loaded for the first time
            if (state.categories.isNotEmpty && state.subCategories.isEmpty && !state.isLoadingSubCategories && state.errorMessage == null) {
              String categoryIdToFetch = state.categories[0].id;
              int index = 0;
              
              if (widget.initialCategoryId != null) {
                final foundIndex = state.categories.indexWhere((c) => c.id == widget.initialCategoryId);
                if (foundIndex != -1) {
                  index = foundIndex;
                  categoryIdToFetch = widget.initialCategoryId!;
                }
              }
              
              setState(() {
                _selectedSidebarIndex = index;
              });
              
              _bloc.add(FetchSubCategoriesEvent(categoryIdToFetch));
            }
          },
          child: BlocBuilder<SearchCategoryBloc, SearchCategoryState>(
            builder: (context, state) {
              if (state.isLoadingCategories && state.categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state.errorMessage != null && state.categories.isEmpty) {
                return Center(child: Text(state.errorMessage!));
              }

              final categories = state.categories;
              if (categories.isEmpty) {
                return const Center(child: Text("No categories available"));
              }

              return Row(
                children: [
                  // --- Left Sidebar Navigation ---
                  Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(right: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final CategoryModel category = categories[index];
                        bool isSelected = _selectedSidebarIndex == index;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedSidebarIndex = index;
                            });
                            _bloc.add(FetchSubCategoriesEvent(category.id));
                          },
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
                                  backgroundImage: CachedNetworkImageProvider(category.image),
                                  onBackgroundImageError: (_, __) => const Icon(Icons.category, color: Colors.grey),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.name,
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
                    child: state.isLoadingSubCategories
                        ? const Center(child: CircularProgressIndicator())
                        : state.errorMessage != null
                            ? Center(child: Text(state.errorMessage!))
                            : state.subCategories.isEmpty
                                ? const Center(child: Text("No subcategories available"))
                                : GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount: state.subCategories.length,
                                    itemBuilder: (context, index) {
                                      final SubCategoryModel subCategory = state.subCategories[index];
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade50,
                                                shape: BoxShape.circle,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: subCategory.image,
                                                fit: BoxFit.contain,
                                                placeholder: (_, __) => const CircularProgressIndicator(),
                                                errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            subCategory.name,
                                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}