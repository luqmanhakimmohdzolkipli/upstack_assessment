part of 'list_bloc.dart';

class ListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListFetched extends ListEvent {}

class SearchListByName extends ListEvent {
  SearchListByName({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}