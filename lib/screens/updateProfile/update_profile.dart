import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/components/styleWidget.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/utils/colors.dart';
import '../../shared/components/components.dart';

class update_profile extends StatefulWidget {
  const update_profile({Key? key}) : super(key: key);

  @override
  State<update_profile> createState() => _update_profileState();
}

class _update_profileState extends State<update_profile>
    with TickerProviderStateMixin {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var adressController = TextEditingController();
  var countryController = TextEditingController();
  var governmentController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController= TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  late File pickedImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    void displayAlertDialog1() {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.light(),
          child: CupertinoAlertDialog(
            actions: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        TransparentButton(
                          iconData: Icons.add,
                          title: "Importer une photo",
                          radius: 8,
                          onPressed: () {
                            print("pressed");
                            SchoolCubit.get(context)
                                .getProfileImage(ImageSource.gallery);
                              finish(context);

                          },
                        ),
                        const SizedBox(height: 20),
                        TransparentButton(
                          iconData: Icons.camera_alt,
                          title: "prendre une photo",
                          radius: 8,
                          onPressed: () {
                            SchoolCubit.get(context)
                                .getProfileImage(ImageSource.camera);
                            finish(context);

                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            'Annuler',
                            style: primaryTextStyle(color: black, size: 18),
                          ),
                          onPressed: () {
                            finish(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return  BlocConsumer<SchoolCubit, SchoolStates>(
      buildWhen: (previous, current) => previous != current ,
      listener: (context, state) {
        if (state is updateProfileAddingDataSuccess){
          showToast(
            text: 'Mise a jour effectué avec succès',
            state: ToastStates.SUCCESS,
          );
        }
        if (state is updateProfileAddingDataLoadingState){
          showToast(
            text: 'En cours',
            state: ToastStates.WARNING,
          );
        }
      },
      builder: (context, state) {
        print('buileded');
        var cubit = SchoolCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SchoolUserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SchoolUserUpdateLoadingState)
                      const SizedBox(
                        height: 10.0,
                      ),
                    SizedBox(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140.0,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        logosColors,
                                        gradient_color,
                                        logosColors,
                                      ],
                                    ),
                                    color: logosColors,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        4.0,
                                      ),
                                      topRight: Radius.circular(
                                        4.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage:
                                  state is SchoolProfileImagePickedSuccessState ? Image.asset('${cubit.newProfileImage!.path}') as ImageProvider :  NetworkImage("${cubit.profileImage}"),
                                ),
                              ),
                              cubit.newProfileImage != null ? Container(
                                width: 42,
                                  height: 42,
                                  child: Image.file(pickedImage ,fit: BoxFit.cover,)) : SizedBox.shrink(),
                              IconButton(
                                onPressed: () {
                                    displayAlertDialog1();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16.0,
                                  ),
                                ),
                                //  onPressed: () {
                                //    cubit.getProfileImage(ImageSource.gallery);
                                // },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (cubit.profileImage != null)
                      Row(
                        children: [
                          if (cubit.profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    text: 'upload profile image',
                                    onPressed: () {
                                      cubit.uploadImage(cubit.newProfileImage);
                                    },
                                  ),
                                  if (state is SchoolUserUpdateLoadingState)
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  if (state is SchoolUserUpdateLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          const SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                    Column(
                      children: [

                          Text(
                            "Nom et prénom : ${context.watch<SchoolCubit>().studentData?.name} ${context.watch<SchoolCubit>().studentData?.LastName}",
                            style: boldTextStyle(
                                fontFamily: fontFamilyBoldGlobal),
                          ).paddingOnly(bottom: 2),


                            Text(
                            "Classe : ${context.watch<SchoolCubit>().studentData?.classe}",
                            style: secondaryTextStyle(
                                color: logosColors,
                                fontFamily: fontFamilyBoldGlobal),
                          ).paddingOnly(bottom: 16),

                        FormFieldText(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Veuillez saisir un';
                            // }
                            //
                            // return null;
                          },
                          label: 'email',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FormFieldText(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            // if (value!.isEmpty) {
                            //   return 'phone number must not be empty';
                            // }
                            // return null;
                          },
                          label: 'Phone',
                          prefix: Icons.call,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FormFieldText(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            // if (value!.isEmpty) {
                            //   return 'name must not be empty';
                            // }
                            // return null;
                          },
                          label: 'Adresse',
                          prefix: Icons.add_location_alt_outlined,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FormFieldText(
                          controller: countryController,
                          type: TextInputType.text,
                          validate: (value) {
                            // if (value!.isEmpty) {
                            //   return 'bio must not be empty';
                            // }
                            //
                            // return null;
                          },
                          label: 'Pays',
                          prefix: Icons.info_outline,
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),
                        FormFieldText(
                          controller: governmentController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'phone number must not be empty';
                            }

                            return null;
                          },
                          label: 'Gouvernement',
                          prefix: Icons.location_city,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),


                        FormFieldText(
                          controller: passwordController,
                          type: TextInputType.phone,
                          validate: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'phone number must not be empty';
                          //   }
                          //   return null;
                           },
                          label: 'mot de passe',
                          prefix: Icons.lock,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 70.0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                            child: defaultButton(
                              onPressed: () async {
                                  await cubit.updateProfile(
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    government: governmentController.text,
                                    country: countryController.text,
                                    email: emailController.text,
                                    adress: adressController.text,
                                  );
                              },
                              text: 'Mettre à jour',
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },);

  }
}

class TransparentButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double radius;
  final IconData iconData;
  const TransparentButton(
      {required this.title,
      this.onPressed,
      required this.radius,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.06,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white.withOpacity(0.5),
              shadowColor: Colors.white.withOpacity(0.1),
              primary: Colors.white.withOpacity(0.5),
              side: BorderSide(
                width: 1.4,
                color: logosColors.withOpacity(0.5),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)),
            ),
            icon: Icon(iconData, color: logosColors),
            label: Text(
              title,
              style: GoogleFonts.roboto(
                  color: logosColors,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
