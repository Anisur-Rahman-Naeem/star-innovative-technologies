import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    ));

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboard');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. Starry Background
          const StarryBackground(),

          // 2. Mosque Silhouette at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: const MosqueSilhouette(),
            ),
          ),

          // 3. Central Animated Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App Logo
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.nightlight_round,
                        size: 42,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // App Name
                    const Text(
                      'DEEN-STEP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tagline
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Every step counts. Track your habit, build consistency, elevate your spiritual journey.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarryBackground extends StatelessWidget {
  const StarryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Stack(
      children: List.generate(40, (index) {
        return Positioned(
          top: random.nextDouble() * MediaQuery.of(context).size.height * 0.8,
          left: random.nextDouble() * MediaQuery.of(context).size.width,
          child: Container(
            width: random.nextDouble() * 2 + 1,
            height: random.nextDouble() * 2 + 1,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(random.nextDouble() * 0.6 + 0.2),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}

class MosqueSilhouette extends StatelessWidget {
  const MosqueSilhouette({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mosque.png',
      width: double.infinity,
      fit: BoxFit.fitWidth,
      alignment: Alignment.bottomCenter,
    );
  }
}
