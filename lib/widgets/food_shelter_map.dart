import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FoodShelterMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // Rounded corners
      child: SizedBox(
        height: 250, // Box height
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(initialCenter: LatLng(13.0520, 80.2205)),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _getFoodShelterMarkers()),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Nearby Food Shelters",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List of Food Shelter Markers
  List<Marker> _getFoodShelterMarkers() {
    List<Map<String, dynamic>> foodShelters = [
      {"name": "Vadapalani Shelter", "lat": 13.0520, "lng": 80.2205},
      {"name": "Annai Ashram", "lat": 13.0489, "lng": 80.2197},
      {"name": "Golden Catering", "lat": 13.0505, "lng": 80.2250},
      {"name": "Grace Food Services", "lat": 13.0540, "lng": 80.2301},
      {"name": "Sri Balaji Canteen", "lat": 13.0495, "lng": 80.2225},
      {"name": "Goodwill Food Hub", "lat": 13.0562, "lng": 80.2278},
      {"name": "Helping Hands Kitchen", "lat": 13.0511, "lng": 80.2183},
      {"name": "Anbu Catering", "lat": 13.0573, "lng": 80.2321},
      {"name": "Food for All", "lat": 13.0478, "lng": 80.2244},
      {"name": "Sri Krishna Caterers", "lat": 13.0550, "lng": 80.2156},
      {"name": "Divine Meals", "lat": 13.0532, "lng": 80.2289},
      {"name": "Sathyam Kitchen", "lat": 13.0508, "lng": 80.2211},
      {"name": "Mother Teresa Canteen", "lat": 13.0529, "lng": 80.2174},
      {"name": "Poonam Catering Services", "lat": 13.0463, "lng": 80.2267},
      {"name": "Hunger Relief Kitchen", "lat": 13.0516, "lng": 80.2295},
      {"name": "Aarthi Food Supply", "lat": 13.0584, "lng": 80.2203},
      {"name": "Angel's Food Centre", "lat": 13.0569, "lng": 80.2220},
      {"name": "Sri Ganesh Caterers", "lat": 13.0547, "lng": 80.2333},
      {"name": "Hope Meals", "lat": 13.0481, "lng": 80.2162},
      {"name": "Namma Canteen", "lat": 13.0499, "lng": 80.2188},
    ];

    return foodShelters.map((shelter) {
      return Marker(
        width: 40,
        height: 40,
        point: LatLng(shelter["lat"], shelter["lng"]),
        child: Icon(Icons.location_on, color: Colors.red, size: 30),
      );
    }).toList();
  }
}
