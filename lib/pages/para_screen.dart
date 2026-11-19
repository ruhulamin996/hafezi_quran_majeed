import 'package:hafezi_quran_majeed/style/app_colors.dart';
import 'package:hafezi_quran_majeed/style/app_theme.dart';
import 'package:hafezi_quran_majeed/utils/number_converter.dart';
import 'package:material_ui/material_ui.dart';

class ParaScreen extends StatefulWidget {
  const ParaScreen({super.key});

  static const String routeName = '/para_screen';

  @override
  State<ParaScreen> createState() => _ParaScreenState();
}

class _ParaScreenState extends State<ParaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('পারা'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        itemCount: 30,
        itemBuilder: (context, index) {
          int paraNumber = index + 1;
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.whiteColor.withOpacity(0.2),
                child: Text(
                  convertToBengaliDigits('$paraNumber'),
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.whiteColor,
                  )
                ),
              ),
              title: Text(
                'পারা: ${convertToBengaliDigits('$paraNumber')}',
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.whiteColor,
                )
              ),
              subtitle: Text(
                (paraNumber == 1)
                    ? 'পৃষ্ঠা: ${convertToBengaliDigits('2')} - ${convertToBengaliDigits('22')}'
                    : (paraNumber == 29)
                        ? 'পৃষ্ঠা: ${convertToBengaliDigits('563')} - ${convertToBengaliDigits('586')}'
                        : (paraNumber == 30)
                            ? 'পৃষ্ঠা: ${convertToBengaliDigits('587')} - ${convertToBengaliDigits('611')}'
                            : 'পৃষ্ঠা: ${convertToBengaliDigits('${((paraNumber - 1) * 20) + 3}')} - ${convertToBengaliDigits('${(paraNumber * 20) + 2}')}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.7),
                )
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: AppColors.whiteColor),
              onTap: () {
                int targetPageIndex = 0;
                if(paraNumber == 1){
                  targetPageIndex = 0;
                } else {
                  int previousPagesSum = 0;
                  for (int i = 1; i < paraNumber; i++) {
                    if (i <= 28) {
                      previousPagesSum += 20;
                    } else if (i == 29) {
                      previousPagesSum += 24;
                    }
                  }
                  targetPageIndex = previousPagesSum + 1;
                }

                Navigator.pushNamed(
                  context,
                  '/reading_screen',
                  arguments: targetPageIndex,
                );
              },
            ),
          );
        },
      ),
    );
  }
}