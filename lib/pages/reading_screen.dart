import 'package:hafezi_quran_majeed/style/app_colors.dart';
import 'package:hafezi_quran_majeed/style/app_theme.dart';
import 'package:hafezi_quran_majeed/utils/bookmark_manager.dart';
import 'package:hafezi_quran_majeed/utils/number_converter.dart';
import 'package:hafezi_quran_majeed/utils/quran_page_info.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  static const String routeName = '/reading_screen';

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  PageController? _pageController;
  final int _totalPages = 610;
  int _currentPageIndex = 0;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _initializeScreen();
    }
  }

  Future<void> _initializeScreen() async {
    final int? passedPageIndex =
        ModalRoute.of(context)?.settings.arguments as int?;
    int initialPage = 0;

    if (passedPageIndex != null) {
      initialPage = passedPageIndex;
    } else {
      final prefs = await SharedPreferences.getInstance();
      initialPage = prefs.getInt('last_read_page') ?? 0;
    }

    // বর্তমান পৃষ্ঠার ইমেজটি আগে থেকেই ক্যাশ করে রাখা যাতে ব্ল্যাংক না থাকে
    String formatPageNumber = (initialPage + 1).toString().padLeft(3, '0');
    precacheImage(
      AssetImage('assets/images/pages/$formatPageNumber.png'),
      context,
    );

    setState(() {
      _currentPageIndex = initialPage;
      _pageController = PageController(initialPage: _currentPageIndex);
      _isLoading = false;
    });
  }

  Future<void> _saveCurrentPage(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_page', pageIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _pageController == null) {
      return Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          reverse: true,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
            _saveCurrentPage(index);
          },
          itemCount: _totalPages,
          itemBuilder: (context, index) {
            int pageNumber = index + 1;
            String formatPageNumber = pageNumber.toString().padLeft(3, '0');
            String imagePath = 'assets/images/pages/$formatPageNumber.png';

            String rightText;
            String leftText;

            if (index == 0) {
              rightText = 'সূরা আল-ফাতিহা';
              leftText = 'কুরআন মাজিদ';
            } else {
              int adjustedIndex = index - 1;
              List<int> paraPageCounts = List.generate(28, (index) => 20);
              paraPageCounts.add(24);
              paraPageCounts.add(25);

              int paraNumber = 1;
              int pageInPara = 1;
              int currentSum = 0;

              for (int i = 0; i < paraPageCounts.length; i++) {
                if (adjustedIndex < currentSum + paraPageCounts[i]) {
                  paraNumber = i + 1;
                  pageInPara = (adjustedIndex - currentSum) + 1;
                  break;
                }
                currentSum += paraPageCounts[i];
              }

              rightText = 'পারা: ${convertToBengaliDigits('$paraNumber')}';
              leftText = 'পৃষ্ঠা: ${convertToBengaliDigits('$pageInPara')}';
            }

            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: AppTheme.lightTheme.scaffoldBackgroundColor,
                    child: GestureDetector(
                      onDoubleTap: () async {
                        final isSaved = await BookmarkManager.toggleBookmark(index,);
                        if (!context.mounted) return;
                        final info = QuranPageInfo.fromPageIndex(index);
                        final banglaPara = convertToBengaliDigits(info.paraNumber.toString(),);
                        final banglaPageInPara = convertToBengaliDigits(info.pageInPara.toString(),);

                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  isSaved ? Icons.save : Icons.delete_outline,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    isSaved
                                        ? 'বুকমার্ক সেভ হয়েছে — পারা: $banglaPara, পারার পৃষ্ঠা: $banglaPageInPara, সূরা: ${info.suraName}'
                                        : 'বুকমার্ক সরানো হয়েছে — পারা: $banglaPara, পারার পৃষ্ঠা: $banglaPageInPara, সূরা: ${info.suraName}',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.whiteColor),
                                  ),
                                ),
                              ],
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      },
                      child: InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: SizedBox.expand(
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    'পৃষ্ঠা $formatPageNumber.png পাওয়া যায়নি',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.errorColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            leftText,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            rightText,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
