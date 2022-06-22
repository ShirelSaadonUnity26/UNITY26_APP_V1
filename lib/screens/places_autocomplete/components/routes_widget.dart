import 'dart:async';

import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/google_places/flutter_google_places.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/screens/address_complete/address_complete_screen.dart';

const kGoogleApiKey = "AIzaSyAm9qYa5nZgjvv0as65XEAtVLgu-04WFVs";

final customTheme = ThemeData(
  brightness: Brightness.light,
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
    themeMode: ThemeMode.light,
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
String ? idUser;
FirebaseAuth auth = FirebaseAuth.instance;
Address ? address;



class _MyService extends State<MyService> {
  Mode? _mode = Mode.overlay;

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
                child: const Text("הזן כתובת"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/search");
                },
              ),
              const SizedBox(
                height: 170,
              ),
            ],
          )),
    );
  }

  Widget _buildDropdownMenu() => DropdownButton(
    value: _mode,
    items: const <DropdownMenuItem<Mode>>[
      DropdownMenuItem<Mode>(
        child: Text("Overlay"),
        value: Mode.overlay,
      ),
      DropdownMenuItem<Mode>(
        child: Text("Fullscreen"),
        value: Mode.fullscreen,
      ),
    ],
    onChanged: (dynamic m) {
      setState(() {
        _mode = m;
      });
    },
  );


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
        hintText: 'חפש כתובת',
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
    inputData();
    stderr.writeln(_places);
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    final address= detail.result.formattedAddress.toString();
    Address ? a= splitAddress(address);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddressComplete(address: a,);
        },
      ),
    );
  }




}


Address splitAddress(String a){


  final split = a.split(',');
  final Map<int, String> values = {
    for (int i = 0; i < split.length; i++)
      i: split[i]
  };
  final x0 = values[0];
  var x1 = values[1];
  final x2= values[2];
  final x3=values[3];
  final x4=values[4];
  final x5=values[5];


  stderr.writeln("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
  stderr.writeln("x0" + x0.toString());
  stderr.writeln("x1" + x1.toString());
  stderr.writeln("x2" + x2.toString());
  stderr.writeln("x3" + x3.toString());
  stderr.writeln("x4" + x4.toString());
  stderr.writeln("x5" + x5.toString());
  final str = x0.toString();
  final s= str.split(" ");
  stderr.writeln(s);
  String x=s[s.length-1];
  stderr.writeln(x);
  stderr.writeln(s.length-1);
  String y=s[0]+" "+s[1];
  stderr.writeln(y);
  x1 ??= '';
  y ??= '';
  x ??= '';
  address=Address(x1.toString(),y.toString(),"",x.toString());
  updateLocation(idUser!, address!);
  return address!;

}


String splitStreetWithoutNumber(String str){
  final s= str.split(" ");
  stderr.writeln(s);
  String x=s[s.length-1];
  stderr.writeln(x);
  stderr.writeln(s.length-1);
  String y=s[0]+" "+s[1];
  stderr.writeln(y);
  return y.toString() + x.toString();


}




String inputData() {
  final User? user = auth.currentUser;
  final uid = user?.uid;
  if (user != null){
    idUser=user.uid;
    stderr.writeln(idUser);
    return idUser!;
  }
  return "none";
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return AddressComplete(address: address!,);
        //     },
        //   ),
        // );
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
      // Scaffold
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