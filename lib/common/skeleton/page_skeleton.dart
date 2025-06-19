import 'package:flutter/material.dart';
import 'package:loader_skeleton/loader_skeleton.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return isDarkMode
        ? DarkCardListSkeleton(length: 5, isCircularImage: true)
        : CardPageSkeleton(totalLines: 5);
  }
}
