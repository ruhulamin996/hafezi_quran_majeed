import 'package:hafezi_quran_majeed/utils/bookmark_model.dart';
import 'package:hafezi_quran_majeed/utils/quran_page_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkManager {
  static const String _storageKey = 'saved_quran_bookmarks';

  static Future<List<BookmarkModel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> rawList = prefs.getStringList(_storageKey) ?? [];
    return rawList.map((item) => BookmarkModel.fromJson(item)).toList();
  }

  static Future<bool> isBookmarked(int pageIndex) async {
    final list = await getBookmarks();
    return list.any((b) => b.pageIndex == pageIndex);
  }

  /// ডাবল ট্যাপ করলে বুকমার্ক সেভ করবে; আগে থেকেই সেভ থাকলে রিমুভ করবে
  static Future<bool> toggleBookmark(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    final List<BookmarkModel> currentList = await getBookmarks();

    final existingIndex =
        currentList.indexWhere((b) => b.pageIndex == pageIndex);

    if (existingIndex != -1) {
      currentList.removeAt(existingIndex);
      await prefs.setStringList(
        _storageKey,
        currentList.map((e) => e.toJson()).toList(),
      );
      return false; // রিমুভ হয়েছে
    } else {
      final info = QuranPageInfo.fromPageIndex(pageIndex);
      final now = DateTime.now();
      final formattedDate =
          '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

      final newBookmark = BookmarkModel(
        pageIndex: pageIndex,
        paraNumber: info.paraNumber,
        pageInPara: info.pageInPara,
        suraName: info.suraName,
        savedAt: formattedDate,
      );

      currentList.insert(0, newBookmark);
      await prefs.setStringList(
        _storageKey,
        currentList.map((e) => e.toJson()).toList(),
      );
      return true; // সেভ হয়েছে
    }
  }

  static Future<void> removeBookmark(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    final List<BookmarkModel> currentList = await getBookmarks();
    currentList.removeWhere((b) => b.pageIndex == pageIndex);
    await prefs.setStringList(
      _storageKey,
      currentList.map((e) => e.toJson()).toList(),
    );
  }
}