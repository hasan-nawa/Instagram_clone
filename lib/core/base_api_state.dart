import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/api_call_status.dart';

abstract class BaseApiState extends Equatable {
  MyApiStatus toApiStatus();

  @override
  List<Object> get props => [];
}
