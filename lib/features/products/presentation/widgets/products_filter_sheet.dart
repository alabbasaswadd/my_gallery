import 'package:flutter/material.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';

class ProductsFilterSheet extends StatefulWidget {
  final ProductFilter currentFilter;
  final ValueChanged<ProductFilter> onApply;

  const ProductsFilterSheet({
    super.key,
    required this.currentFilter,
    required this.onApply,
  });

  @override
  State<ProductsFilterSheet> createState() => _ProductsFilterSheetState();
}

class _ProductsFilterSheetState extends State<ProductsFilterSheet> {
  late String _sort;
  bool? _isActive;
  late TextEditingController _minPrice;
  late TextEditingController _maxPrice;

  final _sorts = const [
    ('Newest', 'الأحدث'),
    ('Oldest', 'الأقدم'),
    ('Price', 'السعر'),
    ('MostViewed', 'الأكثر مشاهدة'),
    ('Alphabetical', 'أبجدي'),
  ];

  @override
  void initState() {
    super.initState();
    _sort = widget.currentFilter.sort;
    _isActive = widget.currentFilter.isActive;
    _minPrice = TextEditingController(
      text: widget.currentFilter.minPrice?.toStringAsFixed(0) ?? '',
    );
    _maxPrice = TextEditingController(
      text: widget.currentFilter.maxPrice?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void dispose() {
    _minPrice.dispose();
    _maxPrice.dispose();
    super.dispose();
  }

  void _apply() {
    widget.onApply(widget.currentFilter.copyWith(
      sort: _sort,
      isActive: _isActive,
      minPrice: double.tryParse(_minPrice.text),
      maxPrice: double.tryParse(_maxPrice.text),
      page: 1,
    ));
    Navigator.pop(context);
  }

  void _reset() {
    widget.onApply(const ProductFilter());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تصفية المنتجات', style: theme.textTheme.titleLarge),
              TextButton(onPressed: _reset, child: const Text('إعادة تعيين')),
            ],
          ),
          const SizedBox(height: 16),
          Text('الترتيب', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _sorts.map((s) {
              return ChoiceChip(
                label: Text(s.$2),
                selected: _sort == s.$1,
                onSelected: (_) => setState(() => _sort = s.$1),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text('الحالة', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('الكل'),
                selected: _isActive == null,
                onSelected: (_) => setState(() => _isActive = null),
              ),
              ChoiceChip(
                label: const Text('نشط'),
                selected: _isActive == true,
                onSelected: (_) => setState(() => _isActive = true),
              ),
              ChoiceChip(
                label: const Text('غير نشط'),
                selected: _isActive == false,
                onSelected: (_) => setState(() => _isActive = false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('نطاق السعر (س.ل)', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minPrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'من'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _maxPrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'إلى'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _apply,
            child: const Text('تطبيق'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
