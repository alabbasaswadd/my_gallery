import 'package:flutter/material.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/network_monitor.dart';
import 'package:my_gallery/shared/widgets/no_internet_view.dart';
import 'package:my_gallery/shared/widgets/service_unavailable_view.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 72,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  /// When the failure is a connectivity/server problem, [kind] lets this widget
  /// show the reassuring illustrated views (no-internet / service-unavailable)
  /// instead of a bare error line — and never a technical detail. Optional so
  /// existing call sites keep working; when omitted, live network health is used
  /// as a fallback so a fully-offline device still gets the friendly view.
  final ApiErrorKind? kind;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.kind,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveKind = kind ??
        (NetworkMonitor.instance.status.value != NetworkStatus.online
            ? ApiErrorKind.network
            : null);

    if (effectiveKind == ApiErrorKind.network ||
        effectiveKind == ApiErrorKind.timeout) {
      return NoInternetView(onRetry: onRetry);
    }
    if (effectiveKind == ApiErrorKind.server) {
      return ServiceUnavailableView(onRetry: onRetry);
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 72,
              color: theme.colorScheme.error.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
