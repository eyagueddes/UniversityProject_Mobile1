import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../layout/cubit/cubit.dart';

import '../../layout/cubit/states.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class get_allMessages extends StatefulWidget {
  const get_allMessages({Key? key}) : super(key: key);

  @override
  State<get_allMessages> createState() => _get_allMessagesState();
}

class _get_allMessagesState extends State<get_allMessages> {
  int currStep = 0;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SchoolCubit()
        ..getUserData()
        ..getMessages(),
      child: BlocConsumer<SchoolCubit, SchoolStates>(
          listener: (context, state) {},
          builder: (context, state) {

            var cubit = SchoolCubit.get(context);
            var steps =  cubit.allMessages.map((message) {
              return Step(title: message['subject'], content: message['text']);
            }).toList();
            // List <Step> steps = [
            //   Step(
            //     title: Text("fgggggg",
            //         style: boldTextStyle(color: appStore.textPrimaryColor)),
            //     subtitle: Text("Add Contact Detail",
            //         style:
            //         primaryTextStyle(color: appStore.textPrimaryColor, size: 14)),
            //     isActive: currStep == 0,
            //     content: Text(
            //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            //         style: secondaryTextStyle(color: appStore.textSecondaryColor)),
            //   ),
            //   Step(
            //     title: Text("${SchoolCubit.get(context).studentData?.name}",
            //         style: boldTextStyle(color: appStore.textPrimaryColor)),
            //     subtitle: Text("Add Contact Detail",
            //         style:
            //         primaryTextStyle(color: appStore.textPrimaryColor, size: 14)),
            //     isActive: currStep == 1,
            //     content: Text(
            //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            //         style: secondaryTextStyle(color: appStore.textSecondaryColor)),
            //   )
            //
            // ];
            return SafeArea(
              child: Scaffold(
                body: Theme(
                  data: ThemeData(backgroundColor: context.scaffoldBackgroundColor),
                  child: Stepper(
                    steps: steps,
                    physics: BouncingScrollPhysics(),
                    type: StepperType.vertical,
                    currentStep: this.currStep,

                    onStepContinue: () {
                      setState(() {
                        if (currStep < steps.length - 1) {
                          currStep = currStep + 1;
                        } else {
                          //currStep = 0;
                          finish(context);
                        }
                      });
                    },
                    onStepCancel: () {
                      finish(context);
                      setState(() {
                        if (currStep > 0) {
                          currStep = currStep - 1;
                        } else {
                          currStep = 0;
                        }
                      });
                    },
                    onStepTapped: (step) {
                      setState(() {
                        currStep = step;
                      });
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = logosColors;

    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
