import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:huungry/features/product/providers/product_provider.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  RangeValues _currentRange = const RangeValues(0, 100);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // initialize from provider if values exist
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prov = Provider.of<ProductProvider>(context, listen: false);
      setState(() {
        final min = prov.minPrice ?? 0;
        final max = prov.maxPrice ?? 100;
        _currentRange = RangeValues(min.toDouble(), max.toDouble());
        _searchController.text = prov.searchQuery;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'ابحث عن منتج...',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (v) => prov.setSearchQuery(v),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.tune, size: 18),
              const SizedBox(width: 8),
              const Text('نطاق السعر'),
              const Spacer(),
              Text(
                '${_currentRange.start.toInt()} - ${_currentRange.end.toInt()}',
              ),
            ],
          ),
          RangeSlider(
            values: _currentRange,
            min: 0,
            max: 1000,
            divisions: 100,
            labels: RangeLabels(
              _currentRange.start.toInt().toString(),
              _currentRange.end.toInt().toString(),
            ),
            onChanged: (range) {
              setState(() => _currentRange = range);
            },
            onChangeEnd: (range) {
              prov.setPriceRange(range.start, range.end);
            },
          ),
        ],
      ),
    );
  }
}
