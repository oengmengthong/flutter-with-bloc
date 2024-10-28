// lib/bloc/contributor_state.dart
import 'package:equatable/equatable.dart';
import '../models/contributor.dart';

abstract class ContributorState extends Equatable {
  const ContributorState();

  @override
  List<Object?> get props => [];
}

class ContributorInitial extends ContributorState {}

class ContributorLoading extends ContributorState {}

class ContributorLoaded extends ContributorState {
  final List<Contributor> contributors;

  const ContributorLoaded(this.contributors);

  @override
  List<Object?> get props => [contributors];
}

class ContributorError extends ContributorState {
  final String message;

  const ContributorError(this.message);

  @override
  List<Object?> get props => [message];
}