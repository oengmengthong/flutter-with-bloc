// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_contributors_app/bloc/contributor_bloc.dart' as _i691;
import 'package:flutter_contributors_app/di/injection_module.dart' as _i949;
import 'package:flutter_contributors_app/repositories/contributor_repository.dart'
    as _i168;
import 'package:flutter_contributors_app/repositories/contributor_repository_impl.dart'
    as _i719;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i361.Dio>(() => injectionModule.dio);
    gh.lazySingleton<_i168.ContributorRepository>(
        () => _i719.ContributorRepositoryImpl(gh<_i361.Dio>()));
    gh.factory<_i691.ContributorBloc>(
        () => _i691.ContributorBloc(gh<_i168.ContributorRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i949.InjectionModule {}
