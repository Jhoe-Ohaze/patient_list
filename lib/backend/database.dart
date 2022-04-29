import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient_list/backend/patient.dart';
import 'package:patient_list/widgets/widget_functions.dart';

enum RequestStatus { FAILED, SUCCESS, PROCESSING }

class Database {
  static final requestBehavior = ValueNotifier<RequestStatus?>(null);
  static int _page = 1;
  static String seed = '';

  static final List<String> genderList = [
    '',
    'male',
    'female',
  ];

  static final List<String> nationalityList = [
    '',
    'AU',
    'BR',
    'CA',
    'CH',
    'DE',
    'DK',
    'ES',
    'FI',
    'FR',
    'GB',
    'IE',
    'IR',
    'NO',
    'NL',
    'NZ',
    'TR',
    'US'
  ];

  static List<Patient> patientList = [];

  static Future<http.Response> _getPatients(String request) {
    return http.get(Uri.parse(request));
  }

  static Future<void> loadData({BuildContext? context, String? gender, String? nationality}) async {
    try {
      requestBehavior.value = RequestStatus.PROCESSING;
      const defaultRequest =
          'https://randomuser.me/api/?exc=login,registered&results=50';
          

      final currentSeed = seed.isEmpty ? '' : '&seed=$seed';
      final currentPage = '&page=$_page';

      final request = defaultRequest + currentSeed + currentPage;

      final response = await _getPatients(request)
          .onError((error, stackTrace) => throw Exception('Failed to get data'))
          .timeout(
            const Duration(minutes: 1),
            onTimeout: () => throw Exception('Connection timed out'),
          );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        seed = responseData['info']['seed'];
        _page++;

        List dynamicList = responseData['results'];
        List<Map<String, dynamic>> mapList = List.generate(dynamicList.length,
            (index) => Map<String, dynamic>.from(dynamicList.elementAt(index)));

        patientList += List.generate(
          mapList.length,
          (index) => Patient(
            mapList.elementAt(index),
          ),
        );
        requestBehavior.value = RequestStatus.SUCCESS;
      } else {
        throw Exception('Failed to get data');
      }
    } on Exception catch (error) {
      requestBehavior.value = RequestStatus.FAILED;
      if (context != null) {
        WidgetFunctions().showSnackBar(context, error.toString());
      }
    }
  }
}
