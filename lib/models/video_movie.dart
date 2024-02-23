// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoMovie {
  final String name; 
  final String key;
  final String type; 
  final int size; 
  final String id; 
  final String site;
  VideoMovie({
    required this.name,
    required this.key,
    required this.type,
    required this.size,
    required this.id,
    required this.site,
  });

  VideoMovie copyWith({
    String? name,
    String? key,
    String? type,
    int? size,
    String? id,
    String? site,
  }) {
    return VideoMovie(
      name: name ?? this.name,
      key: key ?? this.key,
      type: type ?? this.type,
      size: size ?? this.size,
      id: id ?? this.id,
      site: site ?? this.site,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'key': key,
      'type': type,
      'size': size,
      'id': id,
      'site': site,
    };
  }

  factory VideoMovie.fromMap(Map<String, dynamic> map) {
    return VideoMovie(
      name: map['name'] as String,
      key: map['key'] as String,
      type: map['type'] as String,
      size: map['size'] as int,
      id: map['id'] as String,
      site: map['site'] as String,
    );
  }

  String toJson() => json.encode(toMap());

factory VideoMovie.fromJson(Map<String, dynamic> map) {
    return VideoMovie(
      name: map['name'] as String,
      key: map['key'] as String,
      type: map['type'] as String,
      size: map['size'] as int,
      id: map['id'] as String,
      site: map['site'] as String,
    );
  }        
  @override
  String toString() {
    return 'VideoMovie(name: $name, key: $key, type: $type, size: $size, id: $id, site: $site)';
  }

  @override
  bool operator ==(covariant VideoMovie other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.key == key &&
      other.type == type &&
      other.size == size &&
      other.id == id &&
      other.site == site;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      key.hashCode ^
      type.hashCode ^
      size.hashCode ^
      id.hashCode ^
      site.hashCode;
  }
}
