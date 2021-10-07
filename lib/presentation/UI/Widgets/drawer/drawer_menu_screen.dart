import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';

import '../../login_screen.dart';
import '../drawer_item.dart';

class DrawerMenuScreen extends StatelessWidget {
  const DrawerMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              if (token == null)
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('سجل الدخول الآن'),
                  ),
                ),
              if (token != null)
                Image.asset('assets/images/avatar.png', height: 100),
              // Lottie.asset('assets/loading/hi.json',height: 200,),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'أهلا يا $username',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              //Image.asset('assets/images/avatar.png'),
              ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) => buildDrawerItem(
                      HomeCubit.get(context).categories[index],
                      context),
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  itemCount: HomeCubit.get(context).categories.length),
            ],
          ),
        ),
      ),
    );
  }
}
