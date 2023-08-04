import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../../MODEL/search_model.dart';
import '../components/app_style.dart';
import '../components/component.dart';
import 'fill_Application_screen.dart';

class search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  String get searchFieldLabel => LocaleKeys.Search_for_any_services.tr();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme:
          AppBarTheme(toolbarHeight: 65.h, color: Colors.grey, elevation: 0),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          fontFamily: 'Tajawal7',
          color: Colors.white,
        ),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10.h, 5.h, 10.h, 7.h),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: 'Tajawal7',
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  List data = [];
  List<SearchModel> result = [];
  Future<List<SearchModel>?> catidSearch({String? query}) async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/SearchService/${query}'),
        headers: {
          "Content-Type": "application/json",
        },
      );

      var dataa = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        data = dataa['records'];
        result = data.map((e) => SearchModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
                  query.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {}
      return result;
    } catch (e) {}
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<SearchModel>?>(
        future: catidSearch(query: query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SearchModel?>? item = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: SizedBox(
                height: 550.h,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.Our_services.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Tajawal7',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: item!
                              .map((e) => Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          userData.write('serviceId', e.id);
                                          Get.to(const FillApplications());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: Styles.defualtColorWhite,
                                              borderRadius:
                                                  BorderRadius.circular(10.h)),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 130.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.r),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.h)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e!.photoName}'))),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.name!,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.h),
                                                        ),
                                                        SizedBox(
                                                          width: 190.h,
                                                          child: Text(
                                                            e.description!,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Gap(10.h),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Gap(10.h),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
              ),
            );
          }
        });
  }

  final userData = GetStorage();

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.Search.tr(),
        style: const TextStyle(
          fontFamily: 'Tajawal7',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
