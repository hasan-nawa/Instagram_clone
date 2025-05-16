import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';

abstract class ReelsState extends Equatable {
  const ReelsState();

  @override
  List<Object?> get props => [];
}

class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsLoaded extends ReelsState {
  final List<ReelEntity> reels;
  final int currentIndex;
  final ReelEntity? currentReel;

  const ReelsLoaded({
    required this.reels,
    required this.currentIndex,
    required this.currentReel,
  });

  @override
  List<Object?> get props => [reels, currentIndex, currentReel];
}

class ReelsError extends ReelsState {
  final String message;

  const ReelsError({required this.message});

  @override
  List<Object> get props => [message];
}