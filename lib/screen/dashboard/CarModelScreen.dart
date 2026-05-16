import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Bloc/CarModels/car_models_bloc.dart';

class CarModelScreen extends StatelessWidget {
  final String carMakerId;
  final String carMakerName;

  const CarModelScreen({
    super.key,
    required this.carMakerId,
    required this.carMakerName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarModelsBloc()..add(FetchCarModelsEvent(carMakerId: carMakerId)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Car Model",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<CarModelsBloc, CarModelsState>(
          builder: (context, state) {
            if (state is CarModelsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarModelsError) {
              return Center(child: Text(state.message));
            } else if (state is CarModelsLoaded) {
              final models = state.models;
              if (models.isEmpty) {
                return const Center(child: Text("No models available for this brand"));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: models.length,
                itemBuilder: (context, index) {
                  final model = models[index];
                  return _buildModelItem(model);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildModelItem(CarModel model) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipOval(
            child: model.image.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: model.image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.directions_car,
                      color: Colors.grey,
                      size: 40,
                    ),
                  )
                : const Icon(
                    Icons.directions_car,
                    color: Colors.grey,
                    size: 40,
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
