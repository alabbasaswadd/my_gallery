import 'package:flutter/material.dart';
import 'app_text.dart';

enum SnackbarPosition { top, bottom }

class AppSnackbar {
  static OverlayEntry? _currentOverlay;

  static void showError(
    BuildContext context,
    String message, {
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.error,
      position: position,
    );
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.success,
      position: position,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.info,
      position: position,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.warning,
      position: position,
    );
  }

  static void _showSnackbar({
    required BuildContext context,
    required String message,
    required SnackbarType type,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    final snackbarData = _getSnackbarData(type);

    if (position == SnackbarPosition.top) {
      _showTopSnackbar(context, message, snackbarData);
    } else {
      _showBottomSnackbar(context, message, snackbarData);
    }
  }

  static void _showTopSnackbar(
    BuildContext context,
    String message,
    SnackbarData snackbarData,
  ) {
    _currentOverlay?.remove();
    _currentOverlay = null;

    final overlay = Overlay.of(context);
    final mediaQuery = MediaQuery.of(context);

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _TopSnackbarWidget(
        message: message,
        snackbarData: snackbarData,
        topPadding: mediaQuery.padding.top,
        onDismiss: () {
          overlayEntry.remove();
          if (_currentOverlay == overlayEntry) {
            _currentOverlay = null;
          }
        },
      ),
    );

    _currentOverlay = overlayEntry;
    overlay.insert(overlayEntry);
  }

  static void _showBottomSnackbar(
    BuildContext context,
    String message,
    SnackbarData snackbarData,
  ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();

    scaffold.showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: snackbarData.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: snackbarData.backgroundColor.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                snackbarData.backgroundColor,
                snackbarData.backgroundColor.withValues(alpha: 0.88),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(snackbarData.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  message,
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  maxLines: 3,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCloseButton(scaffold),
                  const SizedBox(height: 5),
                  _buildProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(20),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static Widget _buildCloseButton(ScaffoldMessengerState scaffold) {
    return GestureDetector(
      onTap: () => scaffold.hideCurrentSnackBar(),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close_rounded, color: Colors.white, size: 16),
      ),
    );
  }

  static Widget _buildProgressIndicator() {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 4),
      tween: Tween<double>(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Container(
          width: 28,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static SnackbarData _getSnackbarData(SnackbarType type) {
    switch (type) {
      case SnackbarType.error:
        return SnackbarData(
          backgroundColor: const Color(0xFFC62828),
          icon: Icons.error_outline_rounded,
          title: '',
        );
      case SnackbarType.success:
        return SnackbarData(
          backgroundColor: const Color(0xFF388E3C),
          icon: Icons.check_circle_outline_rounded,
          title: '',
        );
      case SnackbarType.info:
        return SnackbarData(
          backgroundColor: const Color(0xFF3B82F6),
          icon: Icons.info_outline_rounded,
          title: '',
        );
      case SnackbarType.warning:
        return SnackbarData(
          backgroundColor: const Color(0xFFE65100),
          icon: Icons.warning_amber_outlined,
          title: '',
        );
    }
  }
}

class SnackbarData {
  final Color backgroundColor;
  final IconData icon;
  final String title;

  SnackbarData({
    required this.backgroundColor,
    required this.icon,
    required this.title,
  });
}

enum SnackbarType { error, success, info, warning }

class _TopSnackbarWidget extends StatefulWidget {
  final String message;
  final SnackbarData snackbarData;
  final double topPadding;
  final VoidCallback onDismiss;

  const _TopSnackbarWidget({
    required this.message,
    required this.snackbarData,
    required this.topPadding,
    required this.onDismiss,
  });

  @override
  State<_TopSnackbarWidget> createState() => _TopSnackbarWidgetState();
}

class _TopSnackbarWidgetState extends State<_TopSnackbarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) _dismiss();
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.topPadding + 10,
      left: 20,
      right: 20,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.snackbarData.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.snackbarData.backgroundColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    widget.snackbarData.backgroundColor,
                    widget.snackbarData.backgroundColor.withValues(alpha: 0.88),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.snackbarData.icon,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText(
                      widget.message,
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _dismiss,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      _buildProgressIndicator(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 4),
      tween: Tween<double>(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Container(
          width: 28,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
