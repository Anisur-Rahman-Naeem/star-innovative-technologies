import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervew_task/features/home/presentation/bloc/location_bloc.dart';
import 'package:intervew_task/features/home/presentation/bloc/location_event.dart';
import 'package:intervew_task/features/home/presentation/bloc/location_state.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Header Location & Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.primary,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  state.isLoading
                                      ? 'locating...'
                                      : state.location,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.wb_sunny,
                            color: Colors.amber,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      const Text(
                        '3 Jumada Al-Awwal, 1447 H',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            DateFormat('HH:mm').format(DateTime.now()),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('EEE, d MMM yyy').format(DateTime.now()),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'In Maghrib in 01h 29m 3s left',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 2. Prayer Times Row
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _prayerItem(
                              '04:52',
                              'Fajr',
                              Icons.nights_stay_outlined,
                              false,
                            ),
                            _prayerItem(
                              '11:51',
                              'Dhuhr',
                              Icons.wb_sunny_outlined,
                              true,
                            ),
                            _prayerItem(
                              '15:00',
                              'Asr',
                              Icons.cloud_outlined,
                              false,
                            ),
                            _prayerItem(
                              '17:40',
                              'Maghrib',
                              Icons.wb_twilight,
                              false,
                            ),
                            _prayerItem(
                              '19:00',
                              'Isha',
                              Icons.bedtime_outlined,
                              false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 3. Question Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Have you prayed Dhuhr?',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '0/5 prayers tracked today',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '?',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 4. Stats Cards Row (Daily Goal & Habit Streak)
                      Row(
                        children: [
                          Expanded(
                            child: _statCard(
                              'Daily Goal',
                              '0/5',
                              'Track 5 prayers to\nunlock goals',
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _statCard(
                              'Your Habit Streak 🔥',
                              '0 days',
                              'Log today to\nbegin streak',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 5. Affirmation Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Icon(
                                  Icons.edit_note,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'AFFIRMATION',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              'Assalamu alaikum! Welcome to your space for spiritual growth. Every big journey begins with a small step. Log your first prayer today to start building a beautiful, consistent habit.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 6. Abundance Verse Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book,
                                      color: AppColors.primary,
                                      size: 18,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'ABUNDANCE VERSE',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Surah An-Naml [27:19]',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpacing.md),
                            Center(
                              child: Text(
                                'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              '"My Lord, enable me to be grateful for Your favor which You have bestowed upon me."',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80), // Padding for bottom navbar
                    ],
                  ),
                ),
              ),

              // 7. Enable Location Overlay Modal (as shown in Figma)
              if (state.showModal)
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const Text(
                            'Enable Location',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          const Text(
                            'To provide you with highly accurate prayer times and the correct Qibla direction, we need to access your device\'s location.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () => context
                                    .read<LocationBloc>()
                                    .add(GetLocationRequested()),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Turn On Location'),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          TextButton(
                            onPressed: () => context
                                .read<LocationBloc>()
                                .add(LocationModalDismissed()),
                            child: const Text(
                              'Maybe Later',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: AppColors.surface,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: 'Community',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Reflect'),
              BottomNavigationBarItem(
                icon: Icon(Icons.mosque),
                label: 'Prayer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _prayerItem(String time, String name, IconData icon, bool isActive) {
    return Column(
      children: [
        Text(
          time,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.black : AppColors.textSecondary,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textPrimary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _statCard(String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.primary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
