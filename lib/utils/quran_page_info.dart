import 'package:hafezi_quran_majeed/utils/sura_data.dart';

class QuranPageInfo {
  final int paraNumber;
  final int pageInPara;
  final String suraName;

  QuranPageInfo({
    required this.paraNumber,
    required this.pageInPara,
    required this.suraName,
  });

  static QuranPageInfo fromPageIndex(int index) {
    // ১. পারা ও পারার ভেতরের পৃষ্ঠা হিসাব
    int paraNumber = 1;
    int pageInPara = 1;

    if (index == 0) {
      paraNumber = 1;
      pageInPara = 1;
    } else {
      int adjustedIndex = index - 1;
      List<int> paraPageCounts = List.generate(28, (_) => 20);
      paraPageCounts.add(24);
      paraPageCounts.add(25);

      int currentSum = 0;
      for (int i = 0; i < paraPageCounts.length; i++) {
        if (adjustedIndex < currentSum + paraPageCounts[i]) {
          paraNumber = i + 1;
          pageInPara = (adjustedIndex - currentSum) + 1;
          break;
        }
        currentSum += paraPageCounts[i];
      }
    }

    // ২. বর্তমান পৃষ্ঠা নম্বর (১-ভিত্তিক) অনুযায়ী সূরার নাম নির্ণয়
    int currentPageNumber = index + 1;
    String currentSuraName = SuraData.surasList.first.name;

    for (final sura in SuraData.surasList) {
      if (sura.page <= currentPageNumber) {
        currentSuraName = sura.name;
      } else {
        break;
      }
    }

    return QuranPageInfo(
      paraNumber: paraNumber,
      pageInPara: pageInPara,
      suraName: currentSuraName,
    );
  }
}