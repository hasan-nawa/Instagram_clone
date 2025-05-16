import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class ExploreContentLoaded extends SearchState {
  final List<PostPreviewEntity> posts;

  ExploreContentLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class SearchResultsLoaded extends SearchState {
  final SearchResultEntity results;
  final String query;

  SearchResultsLoaded({required this.results, required this.query});

  @override
  List<Object> get props => [results, query];
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object> get props => [message];
}