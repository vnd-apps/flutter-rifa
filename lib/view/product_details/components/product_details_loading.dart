import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsLoading extends StatelessWidget {
  const ProductDetailsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 24.0,
                width: 120.0,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 24.0,
                width: double.infinity,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 24.0,
                width: double.infinity,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
