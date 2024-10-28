// lib/repositories/contributor_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/contributor.dart';
import 'contributor_repository.dart';

@LazySingleton(as: ContributorRepository)
class ContributorRepositoryImpl implements ContributorRepository {
  final Dio _dio;

  ContributorRepositoryImpl(this._dio);

  @override
  Future<List<Contributor>> fetchContributors({String? query}) async {
    final response = await _dio.get<List<dynamic>>(
      'https://api.github.com/repos/flutter/flutter/contributors',
    );

    List<Contributor> contributors = response.data!
        .map((json) => Contributor.fromJson(json))
        .toList();

    if (query != null && query.isNotEmpty) {
      contributors = contributors
          .where((contributor) =>
              contributor.login.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return contributors;
  }
}