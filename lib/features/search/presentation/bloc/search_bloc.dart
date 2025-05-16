import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/search/domain/usecases/get_explore_content.dart';
import 'package:instagram_clone/features/search/domain/usecases/search.dart';
import 'package:instagram_clone/features/search/presentation/bloc/search_event.dart';
import 'package:instagram_clone/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Search search;
  final GetExploreContent getExploreContent;

  SearchBloc({
    required this.search,
    required this.getExploreContent,
  }) : super(SearchInitial()) {
    on<LoadExploreContentEvent>(_onLoadExploreContent);
    on<PerformSearchEvent>(_onPerformSearch);
    on<ClearSearchEvent>(_onClearSearch);
  }

  void _onLoadExploreContent(LoadExploreContentEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final posts = await getExploreContent(NoParams());
      emit(ExploreContentLoaded(posts: posts));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  void _onPerformSearch(PerformSearchEvent event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      add(LoadExploreContentEvent());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await search(event.query);
      emit(SearchResultsLoaded(results: results, query: event.query));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<SearchState> emit) {
    add(LoadExploreContentEvent());
  }
}