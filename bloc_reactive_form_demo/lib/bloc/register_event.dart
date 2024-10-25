import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final Map<String, dynamic> formData;

  RegisterSubmitted(this.formData);

  @override
  List<Object> get props => [formData];
}