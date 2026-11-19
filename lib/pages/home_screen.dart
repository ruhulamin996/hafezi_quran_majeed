import 'package:hafezi_quran_majeed/pages/bookmark_screen.dart';
import 'package:hafezi_quran_majeed/pages/para_screen.dart';
import 'package:hafezi_quran_majeed/pages/reading_screen.dart';
import 'package:hafezi_quran_majeed/pages/sura_screen.dart';
import 'package:hafezi_quran_majeed/style/background.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('হাফেজী কুরআন মাজীদ'),
      ),
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 5,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, ReadingScreen.routeName);
              }, child: Text('সম্পূর্ণ কুরআন মাজীদ')),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, ParaScreen.routeName);
              }, child: Text('পারা')),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, SuraScreen.routeName);
              }, child: Text('সূরা')),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, BookmarkScreen.routeName);
              }, child: Text('বুকমার্ক')),
              ElevatedButton(onPressed: (){}, child: Text('সার্চ')),
            ],
          ),
        ),
      ),
    );
  }
}