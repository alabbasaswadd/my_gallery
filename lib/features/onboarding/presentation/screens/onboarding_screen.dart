import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:my_gallery/features/onboarding/data/onboarding_repository.dart';
import 'package:my_gallery/features/onboarding/presentation/widgets/onboarding_illustrations.dart';

// ---------------------------------------------------------------------------
// Page data
// ---------------------------------------------------------------------------

class _PageData {
  const _PageData({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
}

const List<_PageData> _pages = [
  _PageData(
    title: 'استكشف معارض رائعة',
    subtitle: 'اكتشف معارض مذهلة من حولك\nبتجربة تصفح عصرية وممتعة.',
  ),
  _PageData(
    title: 'احجز زيارتك بسهولة',
    subtitle:
        'احجز مكانك، اكتشف تفاصيل الفعاليات،\nواستمتع بتجربة معرض سلسة.',
  ),
  _PageData(
    title: 'ابدأ رحلتك',
    subtitle:
        'مرحباً بك في معرضي.\nاكتشف المعارض وتصفح الفعاليات،\nولا تفوت تجربة مميزة.',
  ),
];

// ---------------------------------------------------------------------------
// OnboardingScreen
// ---------------------------------------------------------------------------

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await OnboardingRepository().markCompleted();
    if (mounted) context.go('/');
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: 450.ms,
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip row — hidden on last page
            AnimatedOpacity(
              opacity: isLastPage ? 0.0 : 1.0,
              duration: 250.ms,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: isLastPage ? null : _finish,
                  child: Text(
                    'تخطّى',
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              flex: 6,
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return _OnboardingPageContent(
                    data: _pages[index],
                    pageIndex: index,
                  );
                },
              ),
            ),

            // Bottom area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: cs.primary,
                      dotColor: cs.primary.withValues(alpha: 0.25),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                      spacing: 6,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons — animated switcher between last-page and nav state
                  AnimatedSwitcher(
                    duration: 300.ms,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: isLastPage
                        ? SizedBox(
                            key: const ValueKey('btn-finish'),
                            width: double.infinity,
                            height: 54,
                            child: FilledButton(
                              onPressed: _finish,
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'ابدأ الآن',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Row(
                            key: const ValueKey('btn-nav'),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: _finish,
                                child: Text(
                                  'تخطّى',
                                  style: TextStyle(color: cs.onSurfaceVariant),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: FilledButton.icon(
                                  onPressed: _next,
                                  style: FilledButton.styleFrom(
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  // In RTL layout arrow_back_ios_rounded points to the right (forward)
                                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                                  label: const Text('التالي'),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _OnboardingPageContent
// ---------------------------------------------------------------------------

class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({
    required this.data,
    required this.pageIndex,
  });

  final _PageData data;
  final int pageIndex;

  Widget _illustrationFor(int index) {
    switch (index) {
      case 0:
        return const GardenIllustration();
      case 1:
        return const HallIllustration();
      case 2:
        return const JourneyIllustration();
      default:
        return const GardenIllustration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Illustration
          Expanded(
            flex: 5,
            child: AspectRatio(
              aspectRatio: 1,
              child: _illustrationFor(pageIndex)
                  .animate(key: ValueKey('illus-$pageIndex'))
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.82, 0.82),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  ),
            ),
          ),

          const SizedBox(height: 28),

          // Text content
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                )
                    .animate(key: ValueKey('title-$pageIndex'))
                    .fadeIn(duration: 400.ms, delay: 100.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 400.ms,
                      delay: 100.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                Text(
                  data.subtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.6,
                  ),
                )
                    .animate(key: ValueKey('subtitle-$pageIndex'))
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 400.ms,
                      delay: 200.ms,
                      curve: Curves.easeOut,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
