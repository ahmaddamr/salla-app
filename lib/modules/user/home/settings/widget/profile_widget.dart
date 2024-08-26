import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/manager/provider/theme_provider.dart';
import 'package:salla_app/modules/user/home/favourite/screen/favourite_screen.dart';
import 'package:salla_app/modules/user/shopLogin/screen/shop_login_screen.dart';
import 'package:salla_app/modules/user/shopLogin/widget/custom_button.dart';
import 'package:salla_app/core/utils_class.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.name,
      required this.email,
      required this.img,
      required this.number});
  final String name;
  final String email;
  final String img;
  final String number;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.network(
                img,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              name,
              style: Styles.onboardingSubTitle
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: Styles.onboardingSubTitle,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Phone Number'),
                        content: Text(number),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 182, 181, 181),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.numbers),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Phone Number',
                        style: Styles.onboardingSubTitle,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 182, 181, 181),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Favorites',
                        style: Styles.onboardingSubTitle,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dark Mode'),
                SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
            ),
                Switch(value: provider.isDarkMode, onChanged:(value) {
              provider.toggleTheme(value);
            },),
              ],
            ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 182, 181, 181),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.email),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email Address',
                        style: Styles.onboardingSubTitle,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            CustomButton(
              text: 'Logout',
              backgroundColor: const Color.fromARGB(255, 141, 197, 254),
              borderSideColor: Colors.transparent,
              style: Styles.onboardingSubTitle,
              onPressed: () {
                CacheHelper.removeData(key: 'token').then(
                  (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopLoginScreen(),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
