// lib/bloc/contributor_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../repositories/contributor_repository.dart';
import 'contributor_event.dart';
import 'contributor_state.dart';

@injectable
class ContributorBloc extends Bloc<ContributorEvent, ContributorState> {
  final ContributorRepository _repository;

  ContributorBloc(this._repository) : super(ContributorInitial()) {
    on<FetchContributors>(_onFetchContributors);
    on<RefreshContributors>(_onRefreshContributors);
    on<SearchContributors>(_onSearchContributors);
  }

  Future<void> _onFetchContributors(
      FetchContributors event, Emitter<ContributorState> emit) async {
    emit(ContributorLoading());
    try {
      final contributors = await _repository.fetchContributors();
      emit(ContributorLoaded(contributors));
    } catch (e) {
      emit(ContributorError(e.toString()));
    }
  }

  Future<void> _onRefreshContributors(
      RefreshContributors event, Emitter<ContributorState> emit) async {
    try {
      final contributors = await _repository.fetchContributors();
      emit(ContributorLoaded(contributors));
    } catch (e) {
      emit(ContributorError(e.toString()));
    }
  }

  Future<void> _onSearchContributors(
      SearchContributors event, Emitter<ContributorState> emit) async {
    emit(ContributorLoading());
    try {
      final contributors =
          await _repository.fetchContributors(query: event.query);
      emit(ContributorLoaded(contributors));
    } catch (e) {
      emit(ContributorError(e.toString()));
    }
  }
}