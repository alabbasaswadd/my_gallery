import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Shared, theme-driven layout for full-screen "state" messages
/// (no-internet, server error, etc.).
///
/// RTL-safe, responsive (scrolls on small screens), light/dark aware, with a
/// subtle entry animation and an optional retry action. Colors come entirely
/// from the active [ColorScheme] — nothing is hardcoded.
class StatusMessageView extends StatelessWidget {
  const StatusMessageView({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    this.iconColor,
    this.pulse = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  /// A gentle breathing animation on the icon (used for no-internet).
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget badge = Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 52, color: iconColor ?? cs.onSurfaceVariant),
    );
    if (pulse) {
      badge = badge
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.06, 1.06),
            duration: 1500.ms,
            curve: Curves.easeInOut,
          );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              badge,
              const SizedBox(height: 28),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium
                    ?.copyWith(color: cs.onSurfaceVariant, height: 1.5),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onAction,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(actionLabel!),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(
          begin: 0.04,
          end: 0,
          duration: 350.ms,
          curve: Curves.easeOut,
        );
  }
}
