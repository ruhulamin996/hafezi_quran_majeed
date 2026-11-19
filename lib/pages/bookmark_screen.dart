import 'package:hafezi_quran_majeed/pages/reading_screen.dart';
import 'package:hafezi_quran_majeed/style/app_colors.dart';
import 'package:hafezi_quran_majeed/style/app_theme.dart';
import 'package:hafezi_quran_majeed/utils/bookmark_manager.dart';
import 'package:hafezi_quran_majeed/utils/bookmark_model.dart';
import 'package:hafezi_quran_majeed/utils/number_converter.dart';
import 'package:material_ui/material_ui.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  static const String routeName = '/bookmark_screen';

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<BookmarkModel> _bookmarks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final items = await BookmarkManager.getBookmarks();
    if (!mounted) return;
    setState(() {
      _bookmarks = items;
      _isLoading = false;
    });
  }

  Future<void> _deleteBookmark(int pageIndex) async {
    await BookmarkManager.removeBookmark(pageIndex);
    await _loadBookmarks();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('বুকমার্ক মুছে ফেলা হয়েছে'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('বুকমার্ক'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'কোনো বুকমার্ক সেভ করা নেই',
                        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                            color: Colors.grey
                          ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'পড়ার সময় পৃষ্ঠায় ডাবল ট্যাপ করে বুকমার্ক সেভ করুন',
                        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey
                        )
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: _bookmarks.length,
                  itemBuilder: (context, index) {
                    final item = _bookmarks[index];
                    final banglaPara = convertToBengaliDigits(item.paraNumber.toString());
                    final banglaPage = convertToBengaliDigits(item.pageInPara.toString());

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 0,
                        ),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            ReadingScreen.routeName,
                            arguments: item.pageIndex,
                          );
                          _loadBookmarks();
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade50,
                          child: const Icon(
                            Icons.bookmark,
                            color: Colors.green,
                          ),
                        ),
                        title: Text(
                          'সূরা: ${item.suraName}',
                          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.whiteColor
                          ),
                        ),
                        subtitle: Text(
                          'পারা: $banglaPara | পৃষ্ঠা: $banglaPage',
                          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.whiteColor.withOpacity(0.8)
                          )
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: AppColors.errorColor.withOpacity(0.8),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: AppColors.whiteColor,
                              size: 25,
                            ),
                            onPressed: () => _deleteBookmark(item.pageIndex),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}