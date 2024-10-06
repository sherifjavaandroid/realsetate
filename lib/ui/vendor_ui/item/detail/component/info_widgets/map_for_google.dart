import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';

class MapForGoogle extends StatefulWidget {
  const MapForGoogle();

  @override
  State<MapForGoogle> createState() => _MapForGoogleState();
}

class _MapForGoogleState extends State<MapForGoogle> {
  double zoom = 16.0;
  final Completer<googlemap.GoogleMapController> _controller =
      Completer<googlemap.GoogleMapController>();
  late Product product;
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    product = itemDetailProvider.product;

    final googlemap.CameraPosition kGooglePlex = googlemap.CameraPosition(
      target: googlemap.LatLng(double.tryParse(product.lat ?? '0.0') ?? 0.0,
          double.tryParse(product.lng ?? '0.0') ?? 0.0),
      zoom: zoom,
    );
    return googlemap.GoogleMap(
        onMapCreated: (googlemap.GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: kGooglePlex,
        circles: <googlemap.Circle>{}..add(googlemap.Circle(
            circleId: const googlemap.CircleId('myCircle'),
            center: googlemap.LatLng(
                double.tryParse(product.lat ?? '0.0') ?? 0.0,
                double.tryParse(product.lng ?? '0.0') ?? 0.0),
            radius: 50,
            fillColor: PsColors.info500.withOpacity(0.7),
            strokeWidth: 3,
            strokeColor: PsColors.error500,
          )),
        onTap: (googlemap.LatLng latLngr) async {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pushNamed(context, RoutePaths.googleMapPin,
              arguments: MapPinIntentHolder(
                  flag: PsConst.VIEW_MAP,
                  mapLat: product.lat ?? '0.0',
                  mapLng: product.lng ?? '0.0'));
        });
  }
}
