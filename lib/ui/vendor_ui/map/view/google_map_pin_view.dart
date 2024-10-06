import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/google_map_pin_call_back_holder.dart';
import '../../../vendor_ui/common/ps_button_widget_with_round_corner.dart';
import '../../common/base/ps_widget_with_appbar_with_no_provider.dart';

// class GoogleMapPinView extends StatefulWidget {
//   const GoogleMapPinView(
//       {required this.flag, required this.maplat, required this.maplng});

//   final String flag;
//   final String? maplat;
//   final String? maplng;

//   @override
//   _MapPinViewState createState() => _MapPinViewState();
// }

// class _MapPinViewState extends State<GoogleMapPinView>
//     with TickerProviderStateMixin {
//   LatLng? latlng;
//   double defaultRadius = 3000;
//   String address = '';
//   late CameraPosition kGooglePlex;
//   GoogleMapController? mapController;
//   Position? _currentPosition;
//   String addressCurrentLocation = '';

//   // dynamic loadAddress() async {
//   //   try {
//   //     final Address locationAddress = await GeoCode().reverseGeocoding(
//   //         latitude: double.parse(widget.maplat!),
//   //         longitude: double.parse(widget.maplng!));

//   //     // final Address first = addresses.first;
//   //     address =
//   //         '${locationAddress.streetAddress}  \n, ${locationAddress.countryName}';
//   //   } catch (e) {
//   //     address = '';
//   //     print(e);
//   //   }
//   // }

//   Future<void> loadAddress(String lat, String lng) async {
//     await placemarkFromCoordinates(double.parse(lat), double.parse(lng))
//         .then((List<Placemark> placemarks) {
//       final Placemark place = placemarks[0];
//       setState(() {
//         address =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((dynamic e) {
//       debugPrint(e);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     latlng ??=
//         LatLng(double.parse(widget.maplat!), double.parse(widget.maplng!));

//   final Widget currentLocationWidget = Positioned(
//       bottom: 2,
//       child: Container(
//         alignment: Alignment.bottomCenter,
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: PSButtonWidgetRoundCorner(
//           colorData: PsColors.buttonColor,
//           hasShadow: false,
//           titleText: 'item_entry__use_current_location'.tr,
//           onPressed: () {
//               Geolocator.getCurrentPosition(
//                      desiredAccuracy: LocationAccuracy.medium,
//                      forceAndroidLocationManager: true)
//                       .then((Position position) {
//                      if (mounted) {
//                        setState(() async {
//                          _currentPosition = position;
//                          final  List<Placemark> placemarks = await placemarkFromCoordinates(
//                                 _currentPosition!.latitude, _currentPosition!.longitude);
//                          final   Placemark place = placemarks[0];

//                             setState(() {
//                               addressCurrentLocation = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';//here you can used place.country and other things also
//                               print(addressCurrentLocation);
//                             });
//                           Navigator.pop(context,
//                                 GoogleMapPinCallBackHolder(address: addressCurrentLocation,
//                                 latLng: LatLng(_currentPosition!.latitude,_currentPosition!.longitude)));
//                        });
//                      }
//                    }).catchError((Object e) {
//                      print(e);
//                    });
//           },
//         ),
//       ),
//     );

//     const double value = 15.0;
//     // 16 - log(scale) / log(2);
//     kGooglePlex = CameraPosition(
//       target:
//           LatLng(double.parse(widget.maplat!), double.parse(widget.maplng!)),
//       zoom: value,
//     );
//     loadAddress(widget.maplat!, widget.maplng!);
//     final Widget pickLocationWidget = InkWell(
//       child: Ink(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: Center(
//             child: Text('map_pin__pick_location'.tr,
//                 textAlign: TextAlign.justify,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium!
//                     .copyWith(fontWeight: FontWeight.bold)),
//           ),
//         ),
//       ),
//       onTap: () async {
//         await loadAddress(
//             latlng!.latitude.toString(), latlng!.longitude.toString());
//         Navigator.pop(context,
//             GoogleMapPinCallBackHolder(address: address, latLng: latlng));
//       },
//     );
//     print('value $value');

//     return PsWidgetWithAppBarWithNoProvider(
//         appBarTitle: 'location_tile__title'.tr,
//         actions: widget.flag == PsConst.PIN_MAP
//             ? <Widget>[
//                 pickLocationWidget,
//               ]
//             : <Widget>[],
//         child: Scaffold(
//           body: Column(
//             children: <Widget>[
//               Flexible(
//                 child: GoogleMap(
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: kGooglePlex,
//                     circles: <Circle>{}..add(Circle(
//                         circleId: CircleId(address),
//                         center: latlng!,
//                         radius: 200,
//                         fillColor: Colors.blue.withOpacity(0.7),
//                         strokeWidth: 3,
//                         strokeColor: Colors.redAccent,
//                       )),
//                     onTap: widget.flag == PsConst.PIN_MAP
//                         ? _handleTap
//                         : _doNothingTap),
//               ),
//               currentLocationWidget
//             ],
//           ),
//         ));
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _handleTap(LatLng latlng) {
//     setState(() {
//       this.latlng = latlng;
//     });
//   }

//   void _doNothingTap(LatLng latlng) {}
// }

class GoogleMapPinView extends StatefulWidget {
  const GoogleMapPinView({
    required this.flag,
    required this.maplat,
    required this.maplng,
    //this.itemEntryProvider
  });

  final String flag;
  final String? maplat;
  final String? maplng;
  //final ItemEntryProvider? itemEntryProvider;

  @override
  _MapPinViewState createState() => _MapPinViewState();
}

class _MapPinViewState extends State<GoogleMapPinView>
    with TickerProviderStateMixin {
  LatLng? latlng;
  double defaultRadius = 3000;
  String address = '';
  Position? _currentPosition;
  late CameraPosition kGooglePlex;
  GoogleMapController? mapController;
  String addressCurrentLocation = '';

  // dynamic loadAddress() async {
  //   try {
  //     final Address locationAddress = await GeoCode().reverseGeocoding(
  //         latitude: double.parse(widget.maplat!),
  //         longitude: double.parse(widget.maplng!));

  //     // final Address first = addresses.first;
  //     address =
  //         '${locationAddress.streetAddress}  \n, ${locationAddress.countryName}';
  //   } catch (e) {
  //     address = '';
  //     print(e);
  //   }
  // }

  Future<void> loadAddress() async {
    await placemarkFromCoordinates(
            double.parse(widget.maplat!), double.parse(widget.maplng!))
        .then((List<Placemark> placemarks) {
      final Placemark place = placemarks[0];
      setState(() {
        address =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((dynamic e) {
      //debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    latlng ??=
        LatLng(double.parse(widget.maplat!), double.parse(widget.maplng!));
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    const double value = 15.0;
    // 16 - log(scale) / log(2);
    kGooglePlex = CameraPosition(
      target:
          LatLng(double.parse(widget.maplat!), double.parse(widget.maplng!)),
      zoom: value,
    );
    loadAddress();

    print('value $value');

    final Widget currentLocationWidget = Positioned(
      bottom: 2,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: PSButtonWidgetRoundCorner(
          colorData: Theme.of(context).primaryColor,
          hasShadow: false,
          titleText: 'item_entry__use_current_location'.tr,
          onPressed: () {
            Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.lowest,
                    forceAndroidLocationManager: true)
                .then((Position position) async {
              _currentPosition = position;
              final List<Placemark> placemarks = await placemarkFromCoordinates(
                  _currentPosition!.latitude, _currentPosition!.longitude);
              final Placemark place = placemarks[0];

              addressCurrentLocation =
                  '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}'; //here you can used place.country and other things also
              print(addressCurrentLocation);
              Navigator.pop(
                  context,
                  GoogleMapPinCallBackHolder(
                      address: addressCurrentLocation,
                      latLng: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude)));
            }).catchError((Object e) {
              print(e);
            });
          },
        ),
      ),
    );

    return PsWidgetWithAppBarWithNoProvider(
        appBarTitle: 'location_tile__title'.tr,
        actions: widget.flag == PsConst.PIN_MAP
            ? <Widget>[
                InkWell(
                  child: Ink(
                    child: Center(
                      child: Text(
                        'map_pin__pick_location'.tr,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    valueHolder.isPickUpOnMap = true;
                    Navigator.pop(
                        context,
                        GoogleMapPinCallBackHolder(
                            address: address, latLng: latlng));
                  },
                ),
                const SizedBox(
                  width: PsDimens.space16,
                ),
              ]
            : <Widget>[],
        child: Scaffold(
            body: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: kGooglePlex,
                circles: <Circle>{}..add(Circle(
                    circleId: CircleId(address),
                    center: latlng!,
                    radius: 200,
                    fillColor: Colors.blue.withOpacity(0.7),
                    strokeWidth: 3,
                    strokeColor: PsColors.error500,
                  )),
                onTap: widget.flag == PsConst.PIN_MAP
                    ? _handleTap
                    : _doNothingTap),
            bottomNavigationBar: widget.flag == PsConst.PIN_MAP
                ? SizedBox(
                    height: PsDimens.space80,
                    child: Center(child: currentLocationWidget),
                  )
                : const SizedBox()));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      this.latlng = latlng;
    });
  }

  void _doNothingTap(LatLng latlng) {}
}
