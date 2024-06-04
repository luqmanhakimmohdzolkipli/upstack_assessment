part of 'list_bloc.dart';

enum ListStatus { initial, success, failure }

class ListState extends Equatable {
  const ListState({
    this.status = ListStatus.initial,
    this.lists = const <ListModel>[],
    this.isSearching = false,
  });

  final ListStatus status;
  final List<ListModel> lists;
  final bool isSearching;

  ListState copyWith({
    ListStatus? status,
    List<ListModel>? lists,
    bool? isSearching
  }) {
    return ListState(
      status: status ?? this.status,
      lists: lists ?? this.lists,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  String toString() {
    return '''ListState { status: $status, lists: ${lists.length}, isSearching: $isSearching}''';
  }

  @override
  List<Object> get props => [status, lists, isSearching];
}