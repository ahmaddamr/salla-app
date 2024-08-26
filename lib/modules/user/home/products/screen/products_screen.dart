import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/models/category_model.dart';
import 'package:salla_app/models/details_model.dart';
import 'package:salla_app/models/home_model.dart';
import 'package:salla_app/modules/user/home/details/screen/details_screen.dart';
import 'package:salla_app/core/utils_class.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18.0);
        }
      },
      builder: (context, state) {
        // ignore: avoid_print
        print(state);
        HomeModel? model = HomeCubit.get(context).homeModel;
        CategoryModel? categoryModel = HomeCubit.get(context).categoryModel;
        DetailsModel? detailsModel = HomeCubit.get(context).detailsModel;

        // ignore: avoid_print
        print('stattus is ${categoryModel?.status}');

        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (model != null && categoryModel != null) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: model.data?.banners
                      ?.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image(
                            image: NetworkImage(
                              '${e.image}',
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      height: 250,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.linearToEaseOut),
                ),
                Text(
                  'categories',
                  style: Styles.login.copyWith(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: categoryModel.data?.data.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.network(
                                categoryModel.data?.data[index].image ?? "",
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 200,
                              color: Colors.black.withOpacity(.8),
                              child: Text(
                                categoryModel.data?.data[index].name ?? "",
                                textAlign: TextAlign.center,
                                style: Styles.onboardingSubTitle
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Products',
                    style: Styles.login.copyWith(color: Colors.black),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  child: GridView.builder(
                    itemCount: model.data?.products?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    img1: model.data?.products?[index].image ??
                                        "",
                                    name: model
                                            .data?.products?[index].name ??
                                        '',
                                    discreption: model.data
                                            ?.products?[index].description ??
                                        '',
                                    imgs: model
                                        .data!.products![index].images![index],
                                    count: model!
                                        .data!.products![index].images!.length),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      Image.network(
                                        model.data?.products?[index].image ??
                                            "",
                                        width: 180,
                                        height: 140,
                                        // fit: BoxFit.fill,
                                      ),
                                      if (model.data?.products?[index]
                                              .discount !=
                                          0)
                                        Container(
                                          color: Colors.red,
                                          child: Text(
                                            'Discount',
                                            style: Styles.onboardingSubTitle
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    model.data?.products?[index].name ?? "",
                                    maxLines: 2,
                                    style: Styles.onboardingSubTitle
                                        .copyWith(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: Text(
                                        "${model.data?.products?[index].price ?? ""} EGP",
                                        maxLines: 2,
                                        style: Styles.onboardingTitle
                                            .copyWith(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    if (model.data?.products?[index].discount !=
                                        0)
                                      Text(
                                        "${model.data?.products?[index].oldPrice ?? ""} EGP",
                                        maxLines: 2,
                                        style: Styles.onboardingTitle.copyWith(
                                            fontSize: 10,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.lineThrough),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    const Spacer(
                                      flex: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              HomeCubit cubit =
                                                  HomeCubit.get(context);
                                              cubit.changeFavourites(model.data
                                                      ?.products?[index].id ??
                                                  0);
                                              print(model.data?.products?[index]
                                                      .id ??
                                                  0);
                                              if (HomeCubit.get(context)
                                                  .favourites[model.data
                                                      ?.products?[index].id ??
                                                  0] = (HomeCubit.get(context)
                                                      .favourites[model
                                                          .data
                                                          ?.products?[index]
                                                          .id ??
                                                      0] ??
                                                  false)) {
                                                Fluttertoast.showToast(
                                                    msg: 'Added Successfuly',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 18.0);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: 'Removed Successfuly',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 18.0);
                                              }
                                              // cubit.HomeData();
                                              // cubit.categoryData();
                                            },
                                            icon: Icon(
                                              Icons.favorite_rounded,
                                              color: HomeCubit.get(context)
                                                              .favourites[
                                                          model
                                                              .data
                                                              ?.products?[index]
                                                              .id] ??
                                                      true
                                                  ? Colors.red
                                                  : Colors.white,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else if (state is HomeErrorState) {
          return const Center(child: Text('An Error Happened'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
