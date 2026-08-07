import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

/// Public listing of the products tied to a single occasion (Wedding, etc.).
class OccasionProductsScreen extends StatefulWidget {
  final int occasionId;
  final String? occasionName;

  const OccasionProductsScreen({
    super.key,
    required this.occasionId,
    this.occasionName,
  });

  @override
  State<OccasionProductsScreen> createState() => _OccasionProductsScreenState();
}

class _OccasionProductsScreenState extends State<OccasionProductsScreen> {
  final _scrollCtrl = ScrollController();
  final List<StorefrontProduct> _products = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasNext = false;
  String? _error;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _load();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _page = 1;
    });
    try {
      final resp = await context
          .read<StorefrontService>()
          .getProducts(occasionId: widget.occasionId, page: 1);
      if (!mounted) return;
      setState(() {
        _products
          ..clear()
          ..addAll(resp.data ?? []);
        _hasNext = resp.pagination?.hasNext ?? false;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          _error = e.message;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'تعذّر تحميل المنتجات';
          _loading = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasNext) return;
    _loadingMore = true;
    try {
      final resp = await context
          .read<StorefrontService>()
          .getProducts(occasionId: widget.occasionId, page: _page + 1);
      if (!mounted) return;
      setState(() {
        _page += 1;
        _products.addAll(resp.data ?? []);
        _hasNext = resp.pagination?.hasNext ?? false;
      });
    } catch (_) {
      // keep current list; a transient page failure shouldn't wipe results
    } finally {
      _loadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.occasionName ?? 'المناسبة')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return ErrorState(message: _error!, onRetry: _load);
    }
    if (_products.isEmpty) {
      return const EmptyState(
        message: 'لا توجد منتجات لهذه المناسبة',
        icon: Icons.inbox_outlined,
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: GridView.builder(
        controller: _scrollCtrl,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: _products.length,
        itemBuilder: (context, i) =>
            _OccasionProductCard(product: _products[i], index: i),
      ),
    );
  }
}

class _OccasionProductCard extends StatelessWidget {
  final StorefrontProduct product;
  final int index;

  const _OccasionProductCard({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDiscount =
        product.discountPrice != null && product.discountPrice! < product.price;
    final effectivePrice = hasDiscount ? product.discountPrice! : product.price;

    return GestureDetector(
      onTap: () => context.push('/storefront/products/${product.id}'),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: AppNetworkImage(
                imagePath: product.imageUrl,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${effectivePrice.toStringAsFixed(0)} س.ل',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: (index * 40).ms, duration: 300.ms),
    );
  }
}
