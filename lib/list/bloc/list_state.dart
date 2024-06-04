part of 'list_bloc.dart';

enum ListStatus { initial, success, failure }

class ListState extends Equatable {
  const ListState({
    this.status = ListStatus.initial,
    this.lists = const <ListModel>[],
  });

  final ListStatus status;
  final List<ListModel> lists;

  ListState copyWith({
    ListStatus? status,
    List<ListModel>? lists,
  }) {
    return ListState(
      status: status ?? this.status,
      lists: lists ?? this.lists,
    );
  }

  @override
  String toString() {
    return '''ListState { status: $status, lists: ${lists.length}}''';
  }

  @override
  List<Object> get props => [status, lists];
}