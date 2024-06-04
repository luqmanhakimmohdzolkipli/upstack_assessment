import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:upstack_assessment/utils/string_utils.dart';

class ListDetailView extends StatelessWidget {
  const ListDetailView({super.key, required this.listModel});

  final ListModel listModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((listModel.name ?? '').capitalize()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          FontAwesomeIcons.language,
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            listModel.language ?? '',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      listModel.description ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        countChip(
                          text: listModel.stargazersCount.toString(),
                          icon: Icons.star,
                          iconColor: Colors.amber,
                        ),
                        countChip(
                          text: listModel.forksCount.toString(),
                          icon: FontAwesomeIcons.codeFork,
                          iconColor: Colors.blue,
                        ),
                        countChip(
                          text: listModel.watchersCount.toString(),
                          icon: Icons.remove_red_eye,
                          iconColor: Colors.green,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Chip countChip({
    required String text,
    required IconData icon,
    required Color iconColor,
  }) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      label: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}
