import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:upstack_assessment/list/repository/list_repository.dart';

part 'list_event.dart';

part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc({required this.listRepository}) : super(ListState()) {
    on<ListFetched>(_onListFetched);
    on<SearchListByName>(_onListSearched);
  }

  int page = 1;
  List<ListModel> listFetched = [];
  List<ListModel> listSearched = [];
  final ListRepository listRepository;

  Future<void> _onListFetched(
    ListFetched event,
    Emitter<ListState> emit,
  ) async {
    emit(state.copyWith(isSearching: false));
    try {
      if (listFetched.isEmpty && page == 1) {
        emit(state.copyWith(status: ListStatus.initial));
        listFetched = await listRepository.fetchLists(page: page);
        return emit(
          state.copyWith(
            status: ListStatus.success,
            lists: listFetched,
          ),
        );
      }
      listFetched = await listRepository.fetchLists(page: page);
      if (listFetched.isEmpty) {
        return emit(state.copyWith(status: ListStatus.success));
      } else {
        return emit(
          state.copyWith(
            status: ListStatus.success,
            lists: List.of(state.lists)..addAll(listFetched),
          ),
        );
      }
    } catch (e) {
      log('error >> $e');
      emit(state.copyWith(status: ListStatus.failure));
    }
  }

  Future<void> _onListSearched(
    SearchListByName event,
    Emitter<ListState> emit,
  ) async {
    emit(state.copyWith(isSearching: true));
    try {
      if (listSearched.isEmpty && page == 1) {
        emit(state.copyWith(status: ListStatus.initial));
        listSearched = await listRepository.fetchListByName(
          page: page,
          name: event.name,
        );
        return emit(
          state.copyWith(
            status: ListStatus.success,
            lists: listSearched,
          ),
        );
      }
      listSearched = await listRepository.fetchListByName(
        page: page,
        name: event.name,
      );
      if (listSearched.isEmpty) {
        return emit(state.copyWith(status: ListStatus.success));
      } else {
        return emit(
          state.copyWith(
            status: ListStatus.success,
            lists: listSearched,
          ),
        );
      }
    } catch (e) {
      log('error >> $e');
      emit(state.copyWith(status: ListStatus.failure));
    }
  }
}
