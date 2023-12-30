import 'dart:convert';

import 'package:covid_19_tracker_app/Model/world_states_model.dart';
import 'package:covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesApi> fetchWorldStates() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesApi.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
