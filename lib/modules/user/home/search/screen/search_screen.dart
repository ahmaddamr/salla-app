import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/manager/cubits/search_cubit/search_cubit.dart';
import 'package:salla_app/core/utils_class.dart';

class SearchScreen extends StatelessWidget {
  // const SearchScreen({super.key});
  final TextEditingController _searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          var model = SearchCubit().get(context).searchModel;
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _searchController,
                    onChanged: (value) {
                      SearchCubit()
                          .get(context)
                          .searchItem(_searchController.text);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  if (state is SearchLoading)
                    const Center(child: LinearProgressIndicator()),
                  if (state is SearchSuccess)
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: model?.data.products.length,
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
                                          model?.data.products[index].image ??
                                              "",
                                          // 'https://th.bing.com/th/id/OIP.tXQaubbYRZfiOBVdmQLugAHaH3?w=183&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                                          width: 180,
                                          height: 140,
                                          // fit: BoxFit.fill,
                                        ),
                                        // if (0 != 0)
                                        //   Container(
                                        //     color: Colors.red,
                                        //     child: Text(
                                        //       'Discount',
                                        //       style: Styles.onboardingSubTitle
                                        //           .copyWith(
                                        //               color: Colors.white),
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          child: Text(
                                            model?.data.products[index].name ??
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                child: Text(
                                                  "${model?.data.products[index].price ?? ""} EGP",
                                                  maxLines: 2,
                                                  style: Styles.onboardingTitle
                                                      .copyWith(fontSize: 15),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              // if (0 != 0)
                                              //   Text(
                                              //     "${model?.data.products[index].price ?? ""} EGP",
                                              //     maxLines: 2,
                                              //     style: Styles.onboardingTitle
                                              //         .copyWith(
                                              //             fontSize: 10,
                                              //             color: Colors.black,
                                              //             decoration:
                                              //                 TextDecoration
                                              //                     .lineThrough),
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //   ),
                                              const Spacer(
                                                flex: 2,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      // HomeCubit cubit =
                                                      //     HomeCubit.get(context);
                                                      // cubit.changeFavourites(
                                                      //     favScreenModel
                                                      //             .data
                                                      //             ?.data?[index]
                                                      //             .product
                                                      //             ?.id ??
                                                      //         0);
                                                      // print(favScreenModel
                                                      //         .data
                                                      //         ?.data?[index]
                                                      //         .product
                                                      //         ?.id ??
                                                      //     0);
                                                      // cubit.HomeData();
                                                      // cubit.categoryData();
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite_rounded,
                                                      color: HomeCubit.get(
                                                                          context)
                                                                      .favourites[
                                                                  model
                                                                      ?.data
                                                                      .products[
                                                                          index]
                                                                      .id] ??
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
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
