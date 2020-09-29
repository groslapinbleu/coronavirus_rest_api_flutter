import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;
  String _accessToken;

  Future<EndpointData> getEndpointData(Endpoint endpoint) async {
    return await _getDataRefreshingToken<EndpointData>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint));
  }

  Future<EndpointsData> getAllEndPointsData() async {
    return await _getDataRefreshingToken<EndpointsData>(
        onGetData: _getAllEndpointsData);
  }

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        // not authorized => we should refresh the token
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      } else
        rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final data = await Future.wait([
      // tous les appels asynchrones sont faits en parallèle grave à Future.wait !
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(values: {
      // important : récupérer les data[i] dans le même ordre que les appels dans Future.wait
      Endpoint.cases: data[0],
      Endpoint.casesConfirmed: data[1],
      Endpoint.casesSuspected: data[2],
      Endpoint.deaths: data[3],
      Endpoint.recovered: data[4],
    });
  }
}
