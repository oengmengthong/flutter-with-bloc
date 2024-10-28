// lib/bloc/contributor_event.dart
import 'package:equatable/equatable.dart';

abstract class ContributorEvent extends Equatable {
  const ContributorEvent();

  @override
  List<Object?> get props => [];
}

class FetchContributors extends ContributorEvent {}

class RefreshContributors extends ContributorEvent {}

class SearchContributors extends ContributorEvent {
  final String query;

  const SearchContributors(this.query);

  @override
  List<Object?> get props => [query];
}