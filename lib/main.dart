import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervew_task/core/services/location_service.dart';
import 'package:intervew_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:intervew_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:intervew_task/features/home/data/repositories/home_repository_impl.dart';
import 'package:intervew_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:intervew_task/features/home/presentation/bloc/location_bloc.dart';

import 'core/network/api_client.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Network & Data Sources
  final apiClient = ApiClient();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(apiClient);
  final locationService = LocationService();
  final homeRemoteDataSource = HomeRemoteDataSourceImpl(apiClient);
  final homeRepository = HomeRepositoryImpl(remoteDataSource: homeRemoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRemoteDataSource: authRemoteDataSource,
            apiClient: apiClient,
          ),
        ),
        BlocProvider(
          create: (_) => LocationBloc(
            locationService: locationService,
            homeRepository: homeRepository,
          ),
        ),
        BlocProvider(
          create: (_) => HomeBloc(homeRepository: homeRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deen Step',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}