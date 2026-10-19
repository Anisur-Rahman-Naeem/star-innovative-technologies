import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // App Logo Placeholder (Moon icon / illustration)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(Icons.nightlight_round, size: 40, color: Colors.black),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'DEEN-STEP',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Every step counts. Track your habit, build consistency, elevate your spiritual journey.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const Spacer(),
              // Action Buttons matching Figma
              ElevatedButton(
                onPressed: () => context.push('/register'),
                child: const Text('Create Account'),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
                onPressed: () => context.push('/login'),
                child: const Text('Already registered? Log In', style: TextStyle(color: AppColors.textPrimary)),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text('Continue as Guest', style: TextStyle(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}