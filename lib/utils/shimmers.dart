import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerText extends StatelessWidget {
  final double? height;
  final double width;
  const ShimmerText({super.key, required this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        height: height ?? 20,
        width: width,
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          5,
          (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.7),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 20,
                                width: 200,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 20,
                                width: 120,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      decoration: containerDecoration,
                      child: const SizedBox(height: 20, width: 20)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShimmerIconLabel extends StatelessWidget {
  const ShimmerIconLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: containerDecoration,
              child: const SizedBox(height: 20, width: 20)),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10)),
            height: 20,
            width: 200,
          ),
        ],
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7), shape: BoxShape.circle),
      ),
    );
  }
}
