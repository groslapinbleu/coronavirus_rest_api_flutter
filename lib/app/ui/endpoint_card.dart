import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  EndpointCardData(this.title, this.assetName, this.color);
  final String title;
  final String assetName;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, @required this.endpoint, @required this.data})
      : super(key: key);
  final Endpoint endpoint;
  final int data;
  static Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases:
        EndpointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.casesConfirmed: EndpointCardData(
        'Cases confirmed', 'assets/fever.png', Color(0xFFEEDA28)),
    Endpoint.casesSuspected: EndpointCardData(
        'Cases suspected', 'assets/suspect.png', Color(0xFFE99600)),
    Endpoint.deaths:
        EndpointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered:
        EndpointCardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  String get formattedValue {
    if (data != null) {
      final formatter = NumberFormat.decimalPattern();
      return formatter.format(data);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //describeEnum(endpoint),
                _cardsData[endpoint].title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: _cardsData[endpoint].color),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      _cardsData[endpoint].assetName,
                      color: _cardsData[endpoint].color,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.display1.copyWith(
                          color: _cardsData[endpoint].color,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
