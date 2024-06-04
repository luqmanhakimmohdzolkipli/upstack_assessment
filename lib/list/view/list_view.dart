import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upstack_assessment/list/bloc/list_bloc.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:upstack_assessment/list/repository/list_repository.dart';
import 'package:upstack_assessment/list/view/list_detail_view.dart';
import 'package:upstack_assessment/utils/string_utils.dart';

class ListViews extends StatefulWidget {
  const ListViews({super.key});

  @override
  State<ListViews> createState() => _ListViewstate();
}

class _ListViewstate extends State<ListViews> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upstack Assessment'),
      ),
      body: BlocProvider(
        create: (_) => ListBloc(listRepository: ListRepository())..add(ListFetched()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              switch (state.status) {
                case ListStatus.failure:
                  return columnContainer(
                    context,
                    Center(
                      child: Text(
                        'failed to fetch lists',
                      ),
                    ),
                  );
                case ListStatus.success:
                  return columnContainer(
                    context,
                    state.lists.isEmpty
                        ? const Center(
                            child: Text('no lists'),
                          )
                        : EasyRefresh(
                            onRefresh: () async {
                              context.read<ListBloc>()
                                ..listFetched.clear()
                                ..page = 1
                                ..add(ListFetched());
                              _searchController.clear();
                            },
                            onLoad: () async {
                              if (state.isSearching) {
                                context.read<ListBloc>()
                                  ..page += 1
                                  ..add(
                                    SearchListByName(name: _searchController.text),
                                  );
                              } else {
                                context.read<ListBloc>()
                                  ..page += 1
                                  ..add(ListFetched());
                              }
                            },
                            child: ListView.builder(
                              itemCount: state.lists.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (state.lists.isEmpty) {
                                  return const Center(child: Text('no lists'));
                                }
                                ListModel list = state.lists[index];
                                int topicIndex = 0;
                                if (list.topics != null && list.topics!.isNotEmpty) {
                                  topicIndex = list.topics!.length >= 3 ? 3 : list.topics!.length;
                                }

                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListDetailView(listModel: list),
                                    ),
                                  ),
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    color: Colors.grey.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (list.name ?? '').capitalize(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(list.description ?? ''),
                                          const SizedBox(height: 5),
                                          list.topics != null && list.topics!.isNotEmpty
                                              ? Wrap(
                                                  spacing: 8,
                                                  runSpacing: 1,
                                                  children: List.generate(
                                                    topicIndex,
                                                    (index) {
                                                      return Chip(
                                                        visualDensity: VisualDensity.compact,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(50),
                                                        ),
                                                        label: Text(
                                                          list.topics![index],
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  );
                case ListStatus.initial:
                  return columnContainer(
                    context,
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget columnContainer(BuildContext context, Widget child) {
    return Column(children: [
      SearchBar(
        controller: _searchController,
        hintText: 'Please enter repository name',
        elevation: MaterialStateProperty.all(1),
        trailing: [
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
        onSubmitted: (value) {
          if (value.isEmpty) {
            context.read<ListBloc>()
              ..listFetched.clear()
              ..page = 1
              ..add(ListFetched());
          } else {
            context.read<ListBloc>()
              ..page = 1
              ..add(SearchListByName(name: value));
          }
        },
      ),
      const SizedBox(height: 10),
      Expanded(child: child),
    ]);
  }
}
