import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khsomat/presentation/web_view_screen.dart';
import 'package:khsomat/translations/locale_keys.g.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(LocaleKeys.about_us.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(70.r))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      // color: Colors.orange,
                      ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/logosvg.svg',
                      width: 260.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(70), bottom: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 15.sp),
                    text:
                      LocaleKeys.about_us_text.tr(),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen('https://www.khsomat.net'),));

              },
              child: Text(LocaleKeys.open_site.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
