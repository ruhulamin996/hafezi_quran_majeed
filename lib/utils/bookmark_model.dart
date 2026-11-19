import 'dart:convert';

class BookmarkModel {
  final int pageIndex; // 0-indexed page
  final int paraNumber;
  final int pageInPara;
  final String suraName;
  final String savedAt;

  BookmarkModel({
    required this.pageIndex,
    required this.paraNumber,
    required this.pageInPara,
    required this.suraName,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'pageIndex': pageIndex,
      'paraNumber': paraNumber,
      'pageInPara': pageInPara,
      'suraName': suraName,
      'savedAt': savedAt,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      pageIndex: map['pageIndex'] ?? 0,
      paraNumber: map['paraNumber'] ?? 1,
      pageInPara: map['pageInPara'] ?? 1,
      suraName: map['suraName'] ?? '',
      savedAt: map['savedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarkModel.fromJson(String source) =>
      BookmarkModel.fromMap(json.decode(source));
}