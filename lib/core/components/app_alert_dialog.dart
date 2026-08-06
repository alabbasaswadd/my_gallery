import 'package:flutter/material.dart';

import 'app_animation.dart';
import 'app_text.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.onOk,
    required this.onNo,
    required this.title,
    required this.content,
    this.icon,
    this.iconColor,
    this.okLabel,
    this.noLabel,
  });

  final VoidCallback onOk;
  final VoidCallback onNo;
  final String title;
  final String content;
  final IconData? icon;
  final Color? iconColor;
  final String? okLabel;
  final String? noLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectiveIconColor = iconColor ?? cs.primary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: 0.15),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: effectiveIconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? Icons.help_outline_rounded,
                  color: effectiveIconColor,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              AppText(
                title,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                color: cs.onSurface,
              ),
              const SizedBox(height: 10),
              AppText(
                content,
                maxLines: 5,
                textAlign: TextAlign.center,
                fontSize: 14,
                color: cs.onSurfaceVariant,
                height: 1.6,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: AppAnimation(
                      scale: 0.95,
                      child: _OutlineButton(label: noLabel ?? 'لا', onPressed: onNo),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppAnimation(
                      scale: 0.95,
                      child: _FilledButton(label: okLabel ?? 'نعم', onPressed: onOk),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  const _FilledButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: cs.primary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: cs.primary.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: AppText(label, fontSize: 14, fontWeight: FontWeight.w700, color: cs.onPrimary),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant),
        ),
        alignment: Alignment.center,
        child: AppText(label, fontSize: 14, fontWeight: FontWeight.w600, color: cs.onSurfaceVariant),
      ),
    );
  }
}
