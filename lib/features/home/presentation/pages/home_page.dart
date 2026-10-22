import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervew_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:intervew_task/features/home/presentation/bloc/home_event.dart';
import 'package:intervew_task/features/home/presentation/bloc/home_state.dart';
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
  void initState() {
    super.initState();
    // Fetch dashboard data when the page loads
    context.read<HomeBloc>().add(GetDashboardDataRequested());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
            if (!state.isLoading && state.location != 'Gulshan, Dhaka') {
              // Refresh dashboard after location is updated on the server
              context.read<HomeBloc>().add(GetDashboardDataRequested());
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<LocationBloc, LocationState>(
            builder: (context, locationState) {
              if (homeState is HomeLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final dashboard = homeState is HomeLoaded
                  ? homeState.dashboardResponseModel.data
                  : null;

              return Scaffold(
                body: Stack(
                  children: [
                    SafeArea(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<HomeBloc>().add(
                            GetDashboardDataRequested(),
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top section with background image
                              Stack(
                                children: [
                                  // Background Image covering up to prayer timings
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                          AppRadius.lg,
                                        ),
                                        bottomRight: Radius.circular(
                                          AppRadius.lg,
                                        ),
                                      ),
                                      child: Image.asset(
                                        'assets/images/background.png',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: AppColors.surface,
                                                ),
                                      ),
                                    ),
                                  ),
                                  // Gradient Overlay for better text readability
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.4),
                                            Colors.black.withOpacity(0.1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      AppSpacing.md,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 1. Header Location & Date
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      AppRadius.sm,
                                                    ),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: AppColors.primary,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    locationState.isLoading
                                                        ? 'locating...'
                                                        : (locationState
                                                                      .location !=
                                                                  'Gulshan, Dhaka'
                                                              ? locationState
                                                                    .location
                                                              : dashboard
                                                                        ?.location
                                                                        ?.address ??
                                                                    locationState
                                                                        .location),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: AppSpacing.sm),
                                        Text(
                                          dashboard != null
                                              ? '${dashboard.date?.hijri?.day} ${dashboard.date?.hijri?.monthEn}, ${dashboard.date?.hijri?.year} H'
                                              : '3 Jumada Al-Awwal, 1447 H',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              DateFormat('HH:mm')
                                                  .format(DateTime.now()),
                                              style: const TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              DateFormat('EEE, d MMM yyyy')
                                                  .format(DateTime.now()),
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          dashboard != null
                                              ? 'In ${dashboard.nextPrayer?.name} in ${dashboard.nextPrayer?.at} left'
                                              : 'In Maghrib in 01h 29m 3s left',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: AppSpacing.md),
                                        // 2. Prayer Times Row
                                        Container(
                                          padding: const EdgeInsets.all(
                                            AppSpacing.sm,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              AppRadius.md,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(
                                                0.1,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              _prayerItem(
                                                dashboard?.timings?.fajr ??
                                                    '04:52',
                                                'Fajr',
                                                Icons.nights_stay_outlined,
                                                dashboard?.nextPrayer?.name ==
                                                    'Fajr',
                                                isDarkBg: true,
                                              ),
                                              _prayerItem(
                                                dashboard?.timings?.dhuhr ??
                                                    '11:51',
                                                'Dhuhr',
                                                Icons.wb_sunny_outlined,
                                                dashboard?.nextPrayer?.name ==
                                                    'Dhuhr',
                                                isDarkBg: true,
                                              ),
                                              _prayerItem(
                                                dashboard?.timings?.asr ??
                                                    '15:00',
                                                'Asr',
                                                Icons.cloud_outlined,
                                                dashboard?.nextPrayer?.name ==
                                                    'Asr',
                                                isDarkBg: true,
                                              ),
                                              _prayerItem(
                                                dashboard?.timings?.maghrib ??
                                                    '17:40',
                                                'Maghrib',
                                                Icons.wb_twilight,
                                                dashboard?.nextPrayer?.name ==
                                                    'Maghrib',
                                                isDarkBg: true,
                                              ),
                                              _prayerItem(
                                                dashboard?.timings?.isha ??
                                                    '19:00',
                                                'Isha',
                                                Icons.bedtime_outlined,
                                                dashboard?.nextPrayer?.name ==
                                                    'Isha',
                                                isDarkBg: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                child: Column(
                                  children: [
                                    // 3. Question Card
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                        AppSpacing.md,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.md,
                                        ),
                                        border: Border.all(
                                          color: AppColors.border,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Have you prayed ${dashboard?.nextPrayer?.name ?? 'Dhuhr'}?',
                                                style: const TextStyle(
                                                  color: AppColors.textPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                '${dashboard?.dailyGoal?.completed ?? 0}/${dashboard?.dailyGoal?.target ?? 5} prayers tracked today',
                                                style: const TextStyle(
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Text(
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
                                            '${dashboard?.dailyGoal?.completed ?? 0}/${dashboard?.dailyGoal?.target ?? 5}',
                                            'Track 5 prayers to\nunlock goals',
                                          ),
                                        ),
                                        const SizedBox(width: AppSpacing.md),
                                        Expanded(
                                          child: _statCard(
                                            'Your Habit Streak 🔥',
                                            '${dashboard?.streak?.current ?? 0} days',
                                            'Log today to\nbegin streak',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.md),

                                    // 5. Affirmation Card
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                        AppSpacing.md,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.md,
                                        ),
                                        border: Border.all(
                                          color: AppColors.border,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
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
                                          const SizedBox(height: AppSpacing.sm),
                                          Text(
                                            dashboard?.aiReflection?.text ?? 'Assalamu alaikum! Welcome to your space for spiritual growth.',
                                            style: const TextStyle(
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
                                      padding: const EdgeInsets.all(
                                        AppSpacing.md,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.md,
                                        ),
                                        border: Border.all(
                                          color: AppColors.border,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Row(
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                dashboard
                                                        ?.abundanceVerse
                                                        ?.reference ??
                                                    'Surah An-Naml [27:19]',
                                                style: const TextStyle(
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: AppSpacing.md),
                                          Center(
                                            child: Text(
                                              dashboard
                                                      ?.abundanceVerse
                                                      ?.arabic ??
                                                  'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: AppColors.textPrimary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: AppSpacing.sm),
                                          Text(
                                            dashboard
                                                    ?.abundanceVerse
                                                    ?.translation ??
                                                '"My Lord, enable me to be grateful..."',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.md),

                                    // 7. Quick Access Row
                                    Row(
                                      children: [
                                        _quickAccessItem(
                                          'Qibla',
                                          Icons.explore,
                                          const Color(0xFFB4FF39),
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        _quickAccessItem(
                                          'Hijri',
                                          Icons.nightlight_round,
                                          const Color(0xFF9181F4),
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        _quickAccessItem(
                                          'Zakat',
                                          Icons.attach_money,
                                          const Color(0xFFFFB321),
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        _quickAccessItem(
                                          'Times',
                                          Icons.calendar_month,
                                          const Color(0xFFFF5678),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 80),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 7. Enable Location Overlay Modal
                    if (locationState.showModal)
                      Container(
                        color: Colors.black.withOpacity(0.8),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.xl,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF121413),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Location Icon with Circle
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D0D0D),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.primary,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                const Text(
                                  'Enable Location',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Color(0xFF8E8E8E),
                                      fontSize: 15,
                                      height: 1.5,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            'To provide you with highly accurate prayer times and the correct Qibla direction, ',
                                      ),
                                      const TextSpan(
                                        text: 'We need to access',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " your device's location.",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xl),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.black,
                                    minimumSize:
                                        const Size(double.infinity, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: locationState.isLoading
                                      ? null
                                      : () => context.read<LocationBloc>().add(
                                            GetLocationRequested(),
                                          ),
                                  child: locationState.isLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.black,
                                          ),
                                        )
                                      : const Text(
                                          'Turn On Location',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
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
                bottomNavigationBar: _buildBottomNavBar(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.home, 'Home'),
              _navItem(1, Icons.groups, 'Community'),
              _navItem(2, Icons.book, 'Reflect'),
              _navItem(3, Icons.mosque, 'Prayer'),
              _navItem(4, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.background : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: isSelected
              ? Border.all(color: Colors.black, width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _prayerItem(
    String time,
    String name,
    IconData icon,
    bool isActive, {
    bool isDarkBg = false,
  }) {
    final activeColor = AppColors.primary;
    final inactiveColor = isDarkBg ? Colors.white70 : AppColors.textSecondary;
    final nameColor = isDarkBg ? Colors.white : AppColors.textPrimary;

    return Column(
      children: [
        Text(
          time,
          style: TextStyle(
            color: isActive ? activeColor : inactiveColor,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor
                : (isDarkBg ? Colors.white10 : AppColors.background),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.black : inactiveColor,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            color: isActive ? activeColor : nameColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _quickAccessItem(String label, IconData icon, Color iconColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
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
