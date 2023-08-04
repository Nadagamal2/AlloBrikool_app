import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../../MODEL/building_material.dart';
import '../../OtherScreen/services_information.dart';
import '../../components/app_style.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  Future<List<BuldingMaterialModel>> getData2() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/BuildingMaterialsApi/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data);
      return jsonData
          .map((Data) => BuldingMaterialModel.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<BuldingMaterialModel>> getData(String? id) async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/BuildingMaterialsApi/${id}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data);
      return jsonData
          .map((Data) => BuldingMaterialModel.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          LocaleKeys.Building_services.tr(),
          style: TextStyle(
              fontFamily: 'Tajawal7',
              color: Styles.defualtColorBlack,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<BuldingMaterialModel?>>(
        future: getData2(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BuldingMaterialModel?>? item = snapshot.data;
            return Column(
              children: item!
                  .map(
                    (e) => Column(
                      children: [
                        Divider(
                          thickness: .5,
                          height: 20.h,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30.r,
                                backgroundImage: NetworkImage(
                                    'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e!.photoName}'),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 140.h,
                                    child: Text(
                                      e.description,
                                      style: const TextStyle(
                                          fontFamily: 'Tajawal7',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 140.h,
                                    child: Text(
                                      e.location,
                                      style: const TextStyle(
                                        fontFamily: 'Tajawal7',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(ServicesInfo(
                                    img:
                                        'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e.photoName}',
                                    description: e.description,
                                    name: e.name,
                                    BuildingImg: SizedBox(
                                      width: 350.h,
                                      height: 70.h,
                                      child: ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.h),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (context, index) => InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: SizedBox(
                                                            height: 200.h,
                                                            width: 280.h,
                                                            child:
                                                                InteractiveViewer(
                                                                    clipBehavior:
                                                                        Clip
                                                                            .none,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            image:
                                                                                NetworkImage(
                                                                              'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e.buildingMaterialsPhotos[index].imgUrl}',
                                                                            ),
                                                                          )),
                                                                    )),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 50.h,
                                                      width: 70.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e.buildingMaterialsPhotos[index].imgUrl}'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ),
                                          separatorBuilder: (context, index) =>
                                              Gap(10.h),
                                          itemCount:
                                              e.buildingMaterialsPhotos.length),
                                    ),
                                    faceBook: e.faceBookLink,
                                    insta: e.instagramLink,
                                    whats: e.whatsAppNumber,
                                    location: e.location,
                                    phone: e.photoName,
                                  ));
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 80.h,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.Know_more.tr(),
                                      style: TextStyle(
                                        fontFamily: 'Tajawal7',
                                        color: Styles.defualtColorWhite,
                                        fontSize: 11.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: .5,
                          height: 20.h,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
