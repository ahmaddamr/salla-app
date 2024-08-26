import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/models/category_model.dart';
import 'package:salla_app/modules/user/home/categories/widget/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CategoryModel? categoryModel = HomeCubit.get(context).categoryModel;
        return Scaffold(
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
          itemCount: categoryModel?.data?.data.length,
          itemBuilder: (context, index) {
            return CategoryItem(
                img: categoryModel?.data?.data[index].image ?? "",
                text: categoryModel?.data?.data[index].name ?? "");
          },
        ));
      },
    );
  }
}
