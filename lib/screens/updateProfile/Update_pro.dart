import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/screens/updateProfile/Update_profile.dart';
import 'package:university_project_mobile/utils/images.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../utils/colors.dart';

class UpdatePro extends StatefulWidget {
  const UpdatePro({Key? key}) : super(key: key);

  @override
  State<UpdatePro> createState() => _UpdateProState();
}

class _UpdateProState extends State<UpdatePro> {
  var phoneController = TextEditingController();

  var adressController = TextEditingController();

  var countryController = TextEditingController();

  var governmentController = TextEditingController();

  var passwordController = TextEditingController();

  var emailController= TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  //late File pickedImage;

  @override
  void initState() {
    var cubit = SchoolCubit.get(context);
    emailController.text =cubit.studentData!.email!;
  if(cubit.studentData!.phone != null)  phoneController.text = cubit.studentData!.phone!;
    if(cubit.studentData!.adress != null)  adressController.text = cubit.studentData!.adress!;
    if(cubit.studentData!.country != null) countryController.text = cubit.studentData!.country!;
    if(cubit.studentData!.government != null)  governmentController.text = cubit.studentData!.government!;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolCubit>(
      create: (context) => SchoolCubit()..getUserData(),
      child: BlocConsumer<SchoolCubit, SchoolStates>(
        listener: (context, state) {
          if (state is SchoolUploadProfileImageCloudinarySuccessState){
            print('Image Modifié');
            showToast(
              text: 'Image Modifié',
              state: ToastStates.SUCCESS,
            );
          }
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
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SchoolCubit.get(context);
          return state is SchoolLoadingUserDataState ? Center(child: CircularProgressIndicator()) :  Scaffold(
            body:  SingleChildScrollView(
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
                                  child: ClipOval(
                                      child: CachedNetworkImage(

                                        width:100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        imageUrl: context.watch<SchoolCubit>().imageUrlCloudinary != null ? "${ context.read<SchoolCubit>().imageUrlCloudinary}" : cubit.studentData!.avatar!
                                        ,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => CircularProgressIndicator(),
                                      )
                                  ),
                                  radius: 50,
                                ),
                                // CircleAvatar(
                                //   radius: 64.0,
                                //   backgroundColor:
                                //       Theme.of(context).scaffoldBackgroundColor,
                                //   child: CircleAvatar(
                                //     radius: 60.0,
                                //     backgroundImage:
                                //     cubit.imageUrlCloudinary != null  ?   CachedNetworkImage(
                                //       fit: BoxFit.fill,
                                //       imageUrl:"${cubit.imageUrlCloudinary}",
                                //       progressIndicatorBuilder:(context,url,downloadProgress)=>CircularProgressIndicator(value:downloadProgress.progress),
                                //
                                //
                                //     ):  Image.asset('${cubit.newProfileImage!.path}') as ImageProvider,
                                //   ),
                                // ),
                                // cubit.newProfileImage != null ? Container(
                                //     width: 42,
                                //     height: 42,
                                //     child: Image.file(pickedImage ,fit: BoxFit.cover,)) : SizedBox.shrink(),
                                // IconButton(
                                //   onPressed: () {
                                //     displayAlertDialog1(context);
                                //   },
                                //   icon: const CircleAvatar(
                                //     radius: 20.0,
                                //     child: Icon(
                                //       Icons.camera_alt,
                                //       size: 16.0,
                                //     ),
                                //   ),
                                //   //  onPressed: () {
                                //   //    cubit.getProfileImage(ImageSource.gallery);
                                //   // },
                                // ),
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
                                      text: 'Modifier Votre Image',
                                      onPressed: () async {

                                        await cubit.getProfileImage(ImageSource.gallery);

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
                            controller: adressController,
                            type: TextInputType.text,
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
                            type: TextInputType.text,
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
                            type: TextInputType.text,
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
                            child: BlocProvider<SchoolCubit>(
                              create: (context) => SchoolCubit(),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                                child: defaultButton(
                                  onPressed: () async {
                                    print('the url is');
                                    print(context.read<SchoolCubit>().imageUrlCloudinary);
                                    await cubit.updateProfile(
                                      avatar: context.read<SchoolCubit>().imageUrlCloudinary,
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
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
