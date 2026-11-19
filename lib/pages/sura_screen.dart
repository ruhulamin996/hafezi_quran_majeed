
import 'package:hafezi_quran_majeed/pages/reading_screen.dart';
import 'package:hafezi_quran_majeed/style/app_theme.dart';
import 'package:hafezi_quran_majeed/utils/number_converter.dart';
import 'package:hafezi_quran_majeed/utils/sura_data.dart';
import 'package:hafezi_quran_majeed/utils/sura_model.dart';
import 'package:material_ui/material_ui.dart';

class SuraScreen extends StatefulWidget {
  const SuraScreen({super.key});

  static const String routeName = '/sura_screen';

  @override
  State<SuraScreen> createState() => _SuraScreenState();
}

class _SuraScreenState extends State<SuraScreen> {
  // SuraData ক্লাস থেকে সম্পূর্ণ লিস্ট ফেচ করা হলো
  final List<SuraModel> _suraList = SuraData.surasList;
  
  List<SuraModel> _filteredSuraList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSuraList = _suraList;
    _searchController.addListener(_filterSura);
  }

  void _filterSura() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSuraList = _suraList.where((sura) {
        final name = sura.name.toLowerCase();
        final arabic = sura.arabic.toLowerCase();
        final number = sura.number.toString();
        return name.contains(query) || arabic.contains(query) || number.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'সূরার তালিকা',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // সার্চ বার সেকশন
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'সূরা খুঁজুন (নাম বা নম্বর দিয়ে)...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
          
          // সূরার লিস্ট ভিউ
          Expanded(
            child: _filteredSuraList.isEmpty
                ? const Center(
                    child: Text(
                      'কোনো সূরা পাওয়া যায়নি',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredSuraList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    itemBuilder: (context, index) {
                      final sura = _filteredSuraList[index];
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            int targetPage = sura.page - 1; 
                            Navigator.pushNamed(
                              context,
                              ReadingScreen.routeName,
                              arguments: targetPage,
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.green.shade50,
                            child: Text(
                              convertToBengaliDigits(sura.number.toString()),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ),
                          title: Text(
                            sura.name,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white
                            ),
                          ),
                          subtitle: Text(
                            'আয়াত: ${convertToBengaliDigits(sura.verses.toString())} • ${sura.type}',
                            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Text(
                            sura.arabic,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'Arabic'
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}