import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/modules/user/home/search/screen/search_screen.dart';
import 'package:salla_app/core/utils_class.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
              style: Styles.login,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, 'SearchScreen');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SearchScreen()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Styles.secondColor,
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              cubit.changeScreen(index);
            },
            currentIndex: cubit.curerntIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          ),
          body: cubit.bottomScreens[cubit.curerntIndex],
        );
      },
    );
  }
}
//! LogOut Button
// TextButton(
//               onPressed: () {
//                 CacheHelper.removeData(key: 'token').then((value) {
//                   Navigator.pushReplacementNamed(context, 'ShopLoginScreen');
//                 });
//               },
//               child: Text('Logout')),
