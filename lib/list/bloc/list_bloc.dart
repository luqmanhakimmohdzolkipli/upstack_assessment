import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:upstack_assessment/list/repository/list_repository.dart';

part 'list_event.dart';

part 'list_state.dart';

const _listLimit = 10;

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListState()) {
    on<ListFetched>(_onListFetched);
  }

  int page = 1;
  List<ListModel> listFetched = [];
  ListRepository listRepository = ListRepository();

  Future<void> _onListFetched(
    ListFetched event,
    Emitter<ListState> emit,
  ) async {
    try {
      if (listFetched.isEmpty) {
        listFetched = await listRepository.fetchLists(page: page, limit: _listLimit);
        return emit(
          state.copyWith(
            status: ListStatus.success,
            lists: listFetched,
          ),
        );
      }
      listFetched = await listRepository.fetchLists(page: page, limit: _listLimit);
      return emit(
        state.copyWith(
          status: ListStatus.success,
          lists: List.of(state.lists)..addAll(listFetched),
        ),
      );
    } catch (e) {
      log('error >> $e');
      emit(state.copyWith(status: ListStatus.failure));
    }
  }
}
