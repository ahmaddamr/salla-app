// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/models/fav_screen_model.dart';
import 'package:salla_app/core/utils_class.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state);
          FavScreenModel? favScreenModel =
              HomeCubit.get(context).favScreenModel;
          if (state is GetFavoriteErrorState) {
            return Text(state.error.toString());
          } else if (favScreenModel != null) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favScreenModel.data?.data?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            // alignment: Alignment.topLeft,
                            children: [
                              Image.network(
                                favScreenModel
                                        .data?.data?[index].product?.image ??
                                    "",
                                // 'https://th.bing.com/th/id/OIP.tXQaubbYRZfiOBVdmQLugAHaH3?w=183&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                                width: 180,
                                height: 140,
                                // fit: BoxFit.fill,
                              ),
                              if (favScreenModel
                                      .data?.data?[index].product?.discount !=
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  favScreenModel
                                          .data?.data?[index].product?.name ??
                                      "",
                                  maxLines: 2,
                                  style: Styles.onboardingSubTitle
                                      .copyWith(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: Text(
                                        "${favScreenModel.data?.data?[index].product?.price ?? ""} EGP",
                                        maxLines: 2,
                                        style: Styles.onboardingTitle
                                            .copyWith(fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    if (favScreenModel.data?.data?[index]
                                            .product?.discount !=
                                        0)
                                      Text(
                                        "${favScreenModel.data?.data?[index].product?.oldPrice ?? ""} EGP",
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
                                            cubit.changeFavourites(
                                                favScreenModel
                                                        .data
                                                        ?.data?[index]
                                                        .product
                                                        ?.id ??
                                                    0);
                                            print(favScreenModel
                                                    .data
                                                    ?.data?[index]
                                                    .product
                                                    ?.id ??
                                                0);
                                            // cubit.HomeData();
                                            // cubit.categoryData();
                                          },
                                          icon: Icon(
                                            Icons.favorite_rounded,
                                            color: HomeCubit.get(context)
                                                            .favourites[
                                                        favScreenModel
                                                            .data
                                                            ?.data?[index]
                                                            .product
                                                            ?.id] ??
                                                    true
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
