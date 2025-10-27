import 'package:food_quest/core/ui/widgets/data_null_widget.dart';
import 'package:food_quest/core/ui/widgets/shimmer/shimmer_loading_list.dart';
import 'package:flutter/material.dart';

class LoadMoreListViewWidget<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoading;
  final bool isLoadMore;
  final ScrollController scrollController;
  final Widget Function(T item) itemBuilder;
  final bool shimmerLoading;
  final Widget? dataNullWidget;

  const LoadMoreListViewWidget({
    super.key,
    required this.items,
    required this.isLoading,
    required this.isLoadMore,
    required this.scrollController,
    required this.itemBuilder,
    this.shimmerLoading = false,
    this.dataNullWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: shimmerLoading
            ? const ShimmerLoadingList(countItems: 8)
            : const Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      if (dataNullWidget == null) {
        return const DataNullWidget();
      }
      if (dataNullWidget != null) {
        return Center(
          child: dataNullWidget,
        );
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      controller: scrollController,
      itemCount: items.length + (isLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return itemBuilder(items[index]);
        } else {
          return const Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
