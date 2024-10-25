import 'package:bloc/bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchData>(_onFetchData);
  }

  Future<void> _onFetchData(FetchData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 2));

      // Mock data
      final data = List<String>.generate(20, (index) => 'Item ${index + 1}');

      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError('Failed to fetch data'));
    }
  }
}