part of 'search_list_bloc.dart';

enum SearchListStatus { initial, success, failure }

class SearchListState extends Equatable {
  const SearchListState({
    this.status = SearchListStatus.initial,
    this.lists = const <ListModel>[],
  });

  final SearchListStatus status;
  final List<ListModel> lists;

  SearchListState copyWith({
    SearchListStatus? status,
    List<ListModel>? lists,
  }) {
    return SearchListState(
      status: status ?? this.status,
      lists: lists ?? this.lists,
    );
  }

  @override
  String toString() {
    return '''SearchListState { status: $status, lists: ${lists.length}}''';
  }

  @override
  List<Object> get props => [status, lists];
}