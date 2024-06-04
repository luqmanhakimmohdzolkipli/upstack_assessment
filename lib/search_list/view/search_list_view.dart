import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:upstack_assessment/list/view/list_detail_view.dart';
import 'package:upstack_assessment/search_list/bloc/search_list_bloc.dart';
import 'package:upstack_assessment/utils/string_utils.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key});

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => SearchListBloc()..add(SearchListFetched()),
        child: BlocBuilder<SearchListBloc, SearchListState>(builder: (context, state) {
          switch (state.status) {
            case SearchListStatus.failure:
              return const Center(child: Text('failed to fetch lists'));
            case SearchListStatus.success:
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    SearchBar(
                      hintText: 'Please enter repository name',
                      elevation: WidgetStateProperty.all(1),
                      trailing: [
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.search,
                          ),
                        )
                      ],
                      onChanged: (value) {
                        print(value);
                        context.read<SearchListBloc>()..add(SearchListByName(name: value));
                      },
                    ),
                    const SizedBox(height: 10),
                    state.lists.isEmpty
                        ? Expanded(child: Center(child: Text('no lists')))
                        : Expanded(
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
                  ],
                ),
              );
            case SearchListStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
