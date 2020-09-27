import 'package:coronavirus_rest_api_flutter_course/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cases;
  int _casesSuspected;
  int _casesConfirmed;
  int _deaths;
  int _recovered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          icon: Icon(Icons.refresh, color: Colors.white),
          onPressed: () => _refresh(context)),
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: ListView(
        children: [
          EndpointCard(
            title: 'cases',
            data: _cases,
          ),
          EndpointCard(title: 'cases suspected', data: _casesSuspected),
          EndpointCard(title: 'cases confirmed', data: _casesConfirmed),
          EndpointCard(title: 'deaths', data: _deaths),
          EndpointCard(title: 'recovered', data: _recovered),
        ],
      ),
    );
  }

  void _refresh(BuildContext context) async {
    print('_refresh');
    final dataRepository = Provider.of<DataRepository>(context, listen: false);

    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    final casesSuspected =
        await dataRepository.getEndpointData(Endpoint.casesSuspected);
    final casesConfirmed =
        await dataRepository.getEndpointData(Endpoint.casesConfirmed);
    final deaths = await dataRepository.getEndpointData(Endpoint.deaths);
    final recovered = await dataRepository.getEndpointData(Endpoint.recovered);

    setState(() {
      _cases = cases;
      _casesSuspected = casesSuspected;
      _casesConfirmed = casesConfirmed;
      _deaths = deaths;
      _recovered = recovered;
    });
  }
}
