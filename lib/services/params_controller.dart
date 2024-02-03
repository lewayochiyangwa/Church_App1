import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import 'package:iserve_billing/global_constants.dart';
import '../models/jobs_model.dart';



class ParamsController extends GetxController {

  List data = [].obs;
  List partime_data = [].obs;
  List online_data = [].obs;
  List location_data = [].obs;

  List recentPosts_data = [].obs;

  final events = <EventsModel>[].obs;
  final sermons = <SermonsModel>[].obs;
  var loading = true.obs;


  @override
  void onInit() {
    super.onInit();
    getData();
   getEvents();
    getSermons();

  }

  getData()async {
    //print(ip_address+"/ChurchAPI/api/ghmi/params.php");
    final res = await http.get(Uri.parse(ip_address+"/ChurchAPI/api/ghmi/params.php"));
    var jsonData = json.decode(res.body);
    location_data = jsonData['data']['give'];
    print('machado');

  }

  getEvents()async {
    //print(ip_address+"/ChurchAPI/api/ghmi/get_events.php");
    final response = await http.get(
        Uri.parse(ip_address+"/ChurchAPI/api/ghmi/get_events.php"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print("=====================================");
      print(jsonData);
      events.value = jsonData.map((jobJson) => EventsModel.fromJson(jobJson)).toList();
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(events.value);
      loading.value=false;
      update();
    } else {
      throw Exception('Failed to load data');
    }
  }


  getSermons()async {
    print(ip_address+"/ChurchAPI/api/ghmi/get_sermons.php");
    print("=================Tapinda muma Sermons Call Get====================");
    final response = await http.get(
        Uri.parse(ip_address+"/ChurchAPI/api/ghmi/get_sermons.php"));
    print("=================Tapinda muma Sermons after response====================");
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      print(jsonData);
      sermons.value = jsonData.map((jobJson) => SermonsModel.fromJson(jobJson)).toList();
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(sermons.value);
    //  loading.value=false;
      update();
    } else {
      throw Exception('Failed to load data');
    }
  }






}
