// lib/repositories/contributor_repository.dart
import '../models/contributor.dart';

abstract class ContributorRepository {
  Future<List<Contributor>> fetchContributors({String? query});
}