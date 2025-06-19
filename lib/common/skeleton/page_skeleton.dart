import 'package:flutter/material.dart';
import 'package:loader_skeleton/loader_skeleton.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CardPageSkeleton(totalLines: 5);
  }
}
