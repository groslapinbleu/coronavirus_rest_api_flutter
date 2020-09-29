import 'dart:io';

import 'package:coronavirus_rest_api_flutter_course/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/endpoint_card.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/last_updated_status_text.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/show_alert_dialog.dart';
import 'package:coronavirus_rest_api_flutter_course/app/util/last_updated_date_formater.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormater(
        date: _endpointsData != null
            ? _endpointsData.values[Endpoint.cases].date
            : null);

    return Scaffold(
      floatingActionButton: IconButton(
          icon: Icon(Icons.refresh, color: Colors.white),
          onPressed: () => _updateData()),
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(
              text: formatter.formatDateToString() ?? '',
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                data: _endpointsData != null
                    ? _endpointsData.values[endpoint].value
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateData(); // this allows to populate the dashboard at startup
  }

  Future<void> _updateData() async {
    print('_updateData');
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    try {
      final endpointsData = await dataRepository.getAllEndPointsData();
      setState(() {
        _endpointsData = endpointsData;
      });
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connectivity Error',
          content: 'Could not get data from server. Try again later',
          defaultActionText: 'OK');
    } catch (_) {
      // any other type of exception
      showAlertDialog(
          context: context,
          title: 'Unknown error',
          content: 'Please contact support or try again later',
          defaultActionText: 'OK');
    }
  }
}
