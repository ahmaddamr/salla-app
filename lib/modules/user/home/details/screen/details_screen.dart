import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/core/utils_class.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {super.key,
      required this.img1,
      required this.name,
      required this.discreption,
      required this.imgs,
      required this.count});
  final String img1;
  final String name;
  final String discreption;
  final String imgs;
  final int count;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = context.read<HomeCubit>().detailsModel;
        if (state is GetDetailsErrorState) {
          return Text(state.error.toString());
        } else if (model != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Details Screen'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(35),
                        bottomEnd: Radius.circular(35),
                      ),
                      child: Image.network(
                        img1,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 225,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 120.0, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 140),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              img1,
                              fit: BoxFit.fill,
                              width: 150,
                              height: 170,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          'Name',
                          style: Styles.onboardingSubTitle.copyWith(
                              color: Styles.secondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Text(
                          name,
                          style:
                              Styles.onboardingSubTitle.copyWith(fontSize: 16),
                        ),
                        Text(
                          'Discreption',
                          style: Styles.onboardingSubTitle.copyWith(
                              color: Styles.secondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        ReadMoreText(
                          discreption,
                          trimLines: 4,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...Read more',
                          trimExpandedText: ' Read less',
                          style:
                              Styles.onboardingSubTitle.copyWith(fontSize: 16),
                          moreStyle: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                count,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        imgs,
                                        fit: BoxFit.fill,
                                        width: 150,
                                        height: 170,
                                      ),
                                    ),
                                  );
                                },
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
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
