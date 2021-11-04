import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khsomat/presentation/web_view_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('من نحن'),
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
                        'خصومات دوت كوم, هو موقع للتجارة الإلكترونية في جمهوريه مصر العربيه ويضم عدد كبير من المنتجات المختلفه مثل الفئات التي تشمل الإلكترونيات، والأزياء، والمنتجات المنزلية، والساعات،والعطور، وغيرها.ويجذب خصومات دوت كوم عدد كبير من الزائرين شهرياً،وينموبسرعة كبيرة بسبب ازدياد عدد المتسوقين عبر شبكة الإنترنت في جمهوريه مصر العربيه .غالباً ما يسمى خصومات دوت كوم بـ بموطن الخصومات وهو يعمل كموقع للبيع بالتجزئة بالإضافة إلى عمله كسوق للبائعين من جهات خارجية. ويقدم خصومات دوت كوم تجربة تسوق مريحة وآمنة مع إمكانية الدفع عبر الإنترنت، وإمكانية الدفع نقداً عند استلام السلع، وإمكانية إرجاعها مجاناً.تأسس خصومات دوت كوم عام 2021، وهو رائداً في مجال التسوق عبر الإنترنت كموقع خدمي متكامل ، يتيح مجموعه من الخدمات الالكترونيه للزائرين. و بالإضافة إلى مقره الرئيسي في جمهوريه مصر العربيه يلبي خصومات دوت كوم احتياجات الأسواق المحلية بمكاتب تجارية في اغلب محافظات جمهوريه مصر العربيه نسعي جاهدين الي التغيير والتطوير الدائم للموقع مما يتيح الراحه للمستخدمين الموقع او التطبيق الخاص بنا تطور الشعار الخاص بنا',
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen('https://www.facebook.com/A7MeDG0L0L'),));

              },
              child: Text('زور الموقع'),
            ),
          ],
        ),
      ),
    );
  }
}
