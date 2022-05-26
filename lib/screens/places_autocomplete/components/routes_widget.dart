import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:unity26_app_v1/google_places/flutter_google_places.dart';

const kGoogleApiKey = "AIzaSyAm9qYa5nZgjvv0as65XEAtVLgu-04WFVs";

final customTheme = ThemeData(
  brightness: Brightness.dark,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class RoutesWidget extends StatelessWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "My App",
    darkTheme: customTheme,
    themeMode: ThemeMode.dark,
    routes: {
      "/": (_) => const MyService(),
      "/search": (_) => CustomSearchScaffold(),
    },
  );
}

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyService createState() => _MyService();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MyService extends State<MyService> {
  final Mode? _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("My App"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              ElevatedButton(
                child: const Text("Custom"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/search");
                },
              ),
            ],
          )),
    );
  }



  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode!,
      language: "he",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "he")],
    );

    displayPrediction(p, context);
  }
}

Future<void> displayPrediction(Prediction? p, BuildContext context) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
      
    );
    stderr.writeln(_places);
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    final c= detail.result.formattedAddress!.toString();
    final address= detail.result.formattedAddress.toString();
    splitAddress(address,lat,lng);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
     stderr.writeln("${p.description} - $lat/$lng");
  }
}
bool isNumeric(Map<int, String> values1) {

  int i=0;
    while(values1[i]!= null){
      i+=1;
      return double.tryParse(values1.toString()[i]) != null;
    }
    return false;
  }



void splitAddress(String address,double lat,double lng){
  final split = address.split(',');
  final Map<int, String> values = {
    for (int i = 0; i < split.length; i++)
      i: split[i]
  };
    // {0: grubs, 1:  sheep}

  final street = values[0].toString();
  final split1 = street.split(' ');
  final Map<int, String> values1 = {
    for (int i = 0; i < split1.length; i++)
      i: split1[i]

  };
  final ci = values1[0];
  final c = values1[1];
  final cty = values1[2];
  final y = values1[3];
  final c1ity = values1[4];








  stderr.writeln(ci);
  stderr.writeln(c);
  stderr.writeln(cty);
  stderr.writeln(y);
  stderr.writeln(c1ity);
  stderr.writeln(c11ity);





  final city = values[1];
  final country = values[2];

  stderr.writeln(street);
  stderr.writeln(city);
  stderr.writeln(country);


}


// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold({Key? key})
      : super(
    key: key,
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "he",
    components: [Component(Component.country, "IL")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, context);
        stderr.writeln(p);
        

      },
      
      logo: Row(
        children: const [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      stderr.writeln(response.predictions.elementAt(0));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Got answer")),
      // );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}