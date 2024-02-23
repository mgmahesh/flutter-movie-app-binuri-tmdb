// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movie {
  final String title;
  final String backDropPath;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String realseDate;
  final double voteAverage;
  final int id;
  Movie(
      {required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.realseDate,
      required this.voteAverage,
      required this.id});

  Movie copyWith({
    String? title,
    String? backDropPath,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? realseDate,
    double? voteAverage,
    int? id,
  }) {
    return Movie(
      title: title ?? this.title,
      backDropPath: backDropPath ?? this.backDropPath,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      realseDate: realseDate ?? this.realseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'backDropPath': backDropPath.toString(),
      'originalTitle': originalTitle,
      'overview': overview,
      'posterPath': posterPath,
      'realseDate': realseDate,
      'voteAverage': voteAverage,
      'id': id,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backDropPath: map['backDropPath'],
      originalTitle: map['originalTitle'],
      overview: map['overview'],
      posterPath: map['posterPath'],
      realseDate: map['realseDate'],
      voteAverage: map['voteAverage'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backDropPath: (map['backdrop_path'] != null) ? map['backdrop_path'] : '',
      originalTitle: map['original_title'],
      overview: map['overview'],
      posterPath: map['poster_path'] ?? '',
      realseDate: map['release_date'],
      voteAverage: map['vote_average'],
      id: map['id'],
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, backDropPath: $backDropPath, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, realseDate: $realseDate, voteAverage: $voteAverage)';
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.backDropPath == backDropPath &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.realseDate == realseDate &&
        other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        backDropPath.hashCode ^
        originalTitle.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        realseDate.hashCode ^
        voteAverage.hashCode;
  }
}
