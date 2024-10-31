// lib/main.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/product/product_bloc.dart';
import 'presentation/cubits/theme_cubit.dart';
import 'presentation/pages/login_page.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = AuthRepositoryImpl();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(BlocMasteryApp(authRepository: authRepository));
}

class BlocMasteryApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;

  BlocMasteryApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    final productRepository =
        ProductRepositoryImpl(authRepository: authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(productRepository: productRepository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            title: 'Bloc Mastery',
            theme: themeData,
            home: LoginPage(),
          );
        },
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Log errors here or send them to an analytics platform
    super.onError(bloc, error, stackTrace);
  }
}
