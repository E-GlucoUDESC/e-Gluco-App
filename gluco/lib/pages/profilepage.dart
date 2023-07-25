// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gluco/controllers/profilecontroller.dart';
import 'package:gluco/models/user.dart';
import 'package:gluco/services/api.dart';
import 'package:gluco/styles/customcolors.dart';
import 'package:gluco/styles/dateformatter.dart';
import 'package:gluco/styles/defaultappbar.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = API.instance.currentUser!;

  ProfileController controller =
      ProfileController.fromUser(API.instance.currentUser!);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double landscapeCorrection =
        MediaQuery.of(context).orientation == Orientation.landscape ? 0.6 : 1.0;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            CustomColors.bluelight,
            CustomColors.blueGreenlight,
            CustomColors.greenlight,
          ],
        ),
      ),
      child: Scaffold(
        appBar: defaultAppBar(title: 'Meu Perfil'),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.4 *
                              landscapeCorrection,
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColors.blueGreen.withOpacity(1.0),
                              shape: BoxShape.circle,
                            ),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: controller.profilePicVN,
                              builder: (_, hasProfilePic, child) {
                                return hasProfilePic
                                    ? CircleAvatar(
                                        backgroundImage:
                                            controller.profilePic!.image,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.15 *
                                                landscapeCorrection,
                                      )
                                    : Icon(
                                        Icons.person,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.3 *
                                                landscapeCorrection,
                                        color: Colors.white,
                                      );
                              },
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.grey[200],
                          onPressed: controller.updateProfilePic,
                          child: Icon(
                            Icons.photo_camera_rounded,
                            size: 30.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 25.0,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: CustomColors.lightBlue.withOpacity(1.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: CustomColors.scaffWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Form(
                        key: controller.formKey,
                        autovalidateMode: controller.validationMode,
                        onChanged: controller.validate,
                        child: Column(
                          children: [
                            Card(
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 10),
                              elevation: 2.0,
                              color: CustomColors.notwhite,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 15.0),
                                    child: Text(
                                      'Data de Nascimento',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: CustomColors.lightGreen,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    enabled:
                                        false, // Não pode ser alterado por enquanto
                                    controller: controller.birthdate,
                                    inputFormatters: [DateFormatter()],
                                    style: TextStyle(color: Colors.black38),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'dd/mm/aaaa',
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          top: 15.0, left: 15.0),
                                    ),
                                    validator: controller.validatorBirthdate,
                                    keyboardType: TextInputType.datetime,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 10.0,
                                        right: 5),
                                    elevation: 2.0,
                                    color: CustomColors.notwhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 15.0),
                                          child: Text(
                                            'Peso',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: CustomColors.lightGreen
                                                  .withOpacity(1.0),
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: controller.weight,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            // hintText: '70,5',
                                            suffixText: 'kg',
                                            isDense: true,
                                            contentPadding: EdgeInsets.only(
                                                top: 15.0,
                                                left: 15.0,
                                                right: 10.0),
                                          ),
                                          validator: controller.validatorWeight,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 5.0,
                                        right: 10),
                                    elevation: 2.0,
                                    color: CustomColors.notwhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 15.0),
                                          child: Text(
                                            'Altura',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: CustomColors.lightGreen
                                                  .withOpacity(1.0),
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: controller.height,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            // hintText: '1,67',
                                            suffixText: 'm',
                                            isDense: true,
                                            contentPadding: EdgeInsets.only(
                                                top: 15.0,
                                                left: 15.0,
                                                right: 10.0),
                                          ),
                                          validator: controller.validatorHeight,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Card(
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 10),
                              elevation: 2.0,
                              color: CustomColors.notwhite,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 15.0),
                                    child: Text(
                                      'Sexo',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: CustomColors.lightGreen
                                            .withOpacity(1.0),
                                      ),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    value: controller.sex,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 10.0),
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    onChanged: null,
                                    // Não pode ser alterado por enquanto
                                    // (String? value) {
                                    //     controller.sex = value!;
                                    // },
                                    items:
                                        controller.sexList.map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 10),
                              elevation: 2.0,
                              color: CustomColors.notwhite,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 15.0),
                                    child: Text(
                                      'Tipo de Diabetes',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: CustomColors.lightGreen
                                            .withOpacity(1.0),
                                      ),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    value: controller.diabetes,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 10.0),
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    onChanged: null,
                                    // Não pode ser alterado por enquanto
                                    // (String? value) {
                                    //     controller.diabetes = value!;
                                    // },
                                    items: controller.diabetesList
                                        .map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, left: 15.0)),
                            ValueListenableBuilder<bool>(
                              valueListenable: controller.validFormVN,
                              builder: (_, isValid, child) {
                                return Column(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          // a cor tá errada, aparecendo cinza por algum motivo
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        backgroundColor: isValid
                                            ? CustomColors.lightGreen
                                            : Colors.grey,
                                        padding: EdgeInsets.all(15.0),
                                        minimumSize: Size.fromHeight(65),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                        ),
                                      ),
                                      onPressed: !isValid
                                          ? null
                                          : controller.executeUpdate,
                                      child: const Text('Salvar'),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Padding(padding: EdgeInsets.all(20.0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
