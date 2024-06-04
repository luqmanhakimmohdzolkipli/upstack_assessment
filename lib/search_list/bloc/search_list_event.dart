part of 'search_list_bloc.dart';

class SearchListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchListFetched extends SearchListEvent {}

class SearchListByName extends SearchListEvent {
  SearchListByName({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}