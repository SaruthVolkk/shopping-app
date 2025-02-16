// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaginationResponse<T> {
  final String? cursor;
  final List<T>? items;

  PaginationResponse({
    this.items,
    this.cursor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cursor': cursor,
      'items': items?.map((x) => (x as dynamic)?.toMap()).toList(),
    };
  }

  factory PaginationResponse.fromMap(Map<String, dynamic> map, T Function(Map<String, dynamic>) fromMap) {
    return PaginationResponse<T>(
      cursor: map['cursor'] != null ? map['cursor'] as String : null,
      items: map['items'] != null
          ? List<T>.from(
              (map['items'] as List).map<T>(
                (x) => fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationResponse.fromJson(String source, T Function(Map<String, dynamic>) fromMap) =>
      PaginationResponse.fromMap(json.decode(source) as Map<String, dynamic>, fromMap);
}
