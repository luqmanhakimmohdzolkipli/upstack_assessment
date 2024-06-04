// To parse this JSON data, do
//
//     final reposModel = reposModelFromJson(jsonString);

import 'dart:convert';

List<ListModel> listModelFromJson(String str) => List<ListModel>.from(json.decode(str).map((x) => ListModel.fromJson(x)));

String listModelToJson(List<ListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListModel {
    final int? id;
    final String? name;
    final String? fullName;
    final bool? private;
    final String? description;
    final int? stargazersCount;
    final int? watchersCount;
    final String? language;
    final int? forksCount;
    final List<String>? topics;
    final int? forks;
    final int? watchers;

    ListModel({
        this.id,
        this.name,
        this.fullName,
        this.private,
        this.description,
        this.stargazersCount,
        this.watchersCount,
        this.language,
        this.forksCount,
        this.topics,
        this.forks,
        this.watchers,
    });

    factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["id"],
        name: json["name"],
        fullName: json["full_name"],
        private: json["private"],
        description: json["description"],
        stargazersCount: json["stargazers_count"],
        watchersCount: json["watchers_count"],
        language: json["language"],
        forksCount: json["forks_count"],
        topics: json["topics"] == null ? [] : List<String>.from(json["topics"]!.map((x) => x)),
        forks: json["forks"],
        watchers: json["watchers"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "full_name": fullName,
        "private": private,
        "description": description,
        "stargazers_count": stargazersCount,
        "watchers_count": watchersCount,
        "language": language,
        "forks_count": forksCount,
        "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x)),
        "forks": forks,
        "watchers": watchers,
    };
}
