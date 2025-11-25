import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:huungry/features/product/providers/product_provider.dart';
import 'package:huungry/features/product/data/product_model.dart';
import 'package:huungry/features/product/widgets/filter_widget.dart';
import 'package:huungry/features/cart/providers/cart_provider.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  late ProductProvider _provider;
  bool _isGrid = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = Provider.of<ProductProvider>(context, listen: false);
      _provider.loadCategories();
      _provider.loadProducts(reset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prov, _) {
        if (prov.isLoading && prov.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const FilterWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Text(
                    'المنتجات',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'تبديل عرض',
                    icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
                    onPressed: () => setState(() => _isGrid = !_isGrid),
                  ),
                ],
              ),
            ),
            _buildFilters(prov),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => prov.refresh(),
                child:
                    _isGrid
                        ? GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.72,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount:
                              prov.products.length + (prov.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= prov.products.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final Product p = prov.products[index];
                            return _buildCard(p);
                          },
                        )
                        : ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount:
                              prov.products.length + (prov.isLoading ? 1 : 0),
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            if (index >= prov.products.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final Product p = prov.products[index];
                            return _buildListItem(p);
                          },
                        ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilters(ProductProvider prov) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: prov.categories.length,
        itemBuilder: (context, i) {
          final cat = prov.categories[i];
          final selected = prov.selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: selected,
              onSelected: (_) => prov.setCategory(cat),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(Product p) {
    return Consumer<CartProvider>(
      builder:
          (context, cart, _) => GestureDetector(
            onTap:
                () => showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: Text(p.name),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (p.image.isNotEmpty)
                              Image.network(
                                p.image,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            const SizedBox(height: 12),
                            Text('السعر: \$${p.price.toStringAsFixed(2)}'),
                            const SizedBox(height: 12),
                            Text(p.description),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('إغلاق'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cart.addToCart(p);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم إضافة ${p.name} إلى السلة'),
                                  duration: const Duration(milliseconds: 800),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('أضف إلى السلة'),
                          ),
                        ],
                      ),
                ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child:
                        (p.image.isNotEmpty)
                            ? Image.network(p.image, fit: BoxFit.cover)
                            : Container(color: Colors.grey[200]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text('\$${p.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildListItem(Product p) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Consumer<CartProvider>(
        builder:
            (context, cart, _) => ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: SizedBox(
                width: 72,
                height: 72,
                child:
                    (p.image.isNotEmpty)
                        ? Image.network(p.image, fit: BoxFit.cover)
                        : Container(color: Colors.grey[200]),
              ),
              title: Text(
                p.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                p.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${p.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      cart.addToCart(p);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم إضافة ${p.name} إلى السلة'),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                    child: const Text('أضف'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(64, 32),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
