import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:upstack_assessment/list/repository/list_repository.dart';

part 'search_list_event.dart';

part 'search_list_state.dart';

class SearchListBloc extends Bloc<SearchListEvent, SearchListState> {
  SearchListBloc() : super(SearchListState()) {
    on<SearchListFetched>(_onListFetched);
    on<SearchListByName>(_onListSearched);
  }

  ListRepository listRepository = ListRepository();
  List<ListModel> allLists = [];

  Future<void> _onListFetched(
    SearchListFetched event,
    Emitter<SearchListState> emit,
  ) async {
    try {
      if (state.status == SearchListStatus.initial) {
        allLists = await listRepository.fetchAllLists();
        return emit(
          state.copyWith(
            status: SearchListStatus.success,
            lists: allLists,
          ),
        );
      }
    } catch (e) {
      log('error >> $e');
      emit(state.copyWith(status: SearchListStatus.failure));
    }
  }

  Future<void> _onListSearched(
    SearchListByName event,
    Emitter<SearchListState> emit,
  ) async {
    try {
      List<ListModel> filterList = await List.of(allLists);
      if (event.name.isEmpty) {
        filterList = await List.of(allLists);
      } else {
        filterList = await List.of(allLists).where((element) => element.name!.contains(event.name)).toList();
      }
      return emit(
        state.copyWith(
          status: SearchListStatus.success,
          lists: filterList,
        ),
      );
    } catch (e) {
      log('error >> $e');
      emit(state.copyWith(status: SearchListStatus.failure));
    }
  }
}
