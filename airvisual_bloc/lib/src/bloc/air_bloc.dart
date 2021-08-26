import 'dart:convert';

import 'package:airvisual_bloc/src/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class AirBloc {
  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc() {
    fetch();
  }

  Future<AirResult> fetchData() async {
    var url = 'https://api.airvisual.com/v2/nearest_city?key=61de6f57-da2b-47e1-86fc-14bd1e08354f';
    var response = await http.get(url);

    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetch() async {
    var airResult = await await fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult => _airSubject.stream;
}