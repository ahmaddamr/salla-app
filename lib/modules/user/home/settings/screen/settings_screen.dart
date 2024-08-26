import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/modules/user/home/settings/widget/profile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var model = HomeCubit.get(context).loginModel;
          if (state is GetProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProfileErrorState) {
            return Text(state.error.toString());
          } else if (model != null) {
            return ProfileWidget(
              name: model.data?.name ?? '',
              email: model.data?.email ?? '',
              img: model.data?.image ?? '',
              number: model.data?.phone.toString() ?? '',
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}
