import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class notices extends StatelessWidget {
  const notices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        NoticesCubit()
          ..getNotices(),
        child: BlocConsumer<NoticesCubit, NoticesStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = NoticesCubit.get(context);
              return Scaffold(
                  body:  MaterialButton(onPressed: () {
                    print(cubit.getNotices());
                  },)
              );
            }));
  }
}