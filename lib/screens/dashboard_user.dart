import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';
import 'dart:async';

class DashboardUser extends StatefulWidget {
  @override
  _DashboardUserState createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  TextEditingController _postController = TextEditingController();
  DateTime? _needBeforeDate;
  File? _selectedImage;
  bool _isPosted = false;

  List<Map<String, dynamic>> supplierPosts = [
    {
      "text": "Anonymous Supplier: I have 10 kg of rice available.",
      "likes": 0,
      "comments": []
    },
    {
      "text": "Anonymous Supplier: Fresh vegetables up for donation.",
      "likes": 0,
      "comments": []
    },
    {
      "text": "Anonymous Supplier: 5 liters of milk available.",
      "likes": 0,
      "comments": []
    },
    {
      "text": "Anonymous Supplier: 3 kg of wheat ready for pickup.",
      "likes": 0,
      "comments": []
    },
    {
      "text": "Anonymous Supplier: 20 loaves of bread available.",
      "likes": 0,
      "comments": []
    },
  ];

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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickNeedBeforeDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _needBeforeDate = pickedDate;
      });
    }
  }

  void _postContent() {
    if (_postController.text.isNotEmpty || _selectedImage != null) {
      setState(() {
        _postController.clear();
        _selectedImage = null;
        _isPosted = true;
      });
      Future.delayed(Duration(seconds: 10), () {
        setState(() {
          _isPosted = false;
        });
      });
    }
  }

  void _likePost(int index) {
    setState(() {
      supplierPosts[index]["likes"] += 1;
    });
  }

  void _commentOnPost(int index, String comment) {
    setState(() {
      supplierPosts[index]["comments"].add(comment);
    });
  }

  List<Marker> _getFoodShelterMarkers() {
    return foodShelters
        .map((shelter) => Marker(
              point: LatLng(shelter["lat"], shelter["lng"]),
              width: 80,
              height: 40,
              child: Column(
                children: [
                  Icon(Icons.location_on, color: Colors.red, size: 40),
                  Text(shelter["name"],
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Dashboard"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(13.0520, 80.2205),
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: _getFoodShelterMarkers(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/user_dp.png'),
                          radius: 25,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _postController,
                            decoration: InputDecoration(
                              hintText: "Create a post...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_selectedImage != null) ...[
                      SizedBox(height: 10),
                      Image.file(_selectedImage!, height: 100),
                    ],
                    if (_needBeforeDate != null) ...[
                      SizedBox(height: 10),
                      Text(
                          "Need Before: ${_needBeforeDate!.toLocal().toString().split(' ')[0]}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(Icons.image, color: Colors.green),
                          label: Text("Add Photo"),
                        ),
                        TextButton.icon(
                          onPressed: () => _pickNeedBeforeDate(context),
                          icon: Icon(Icons.date_range, color: Colors.blue),
                          label: Text("Set Need Before Date"),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _postContent,
                      child:
                          Text("Post", style: TextStyle(color: Colors.white)),
                    ),
                    if (_isPosted) ...[
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 5),
                          Text("Posted", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: supplierPosts.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(supplierPosts[index]["text"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.thumb_up, color: Colors.blue),
                                onPressed: () => _likePost(index),
                              ),
                              Text("${supplierPosts[index]["likes"]} Likes"),
                            ],
                          ),
                          ...List.generate(
                              supplierPosts[index]["comments"].length, (i) {
                            return Text(
                                "- ${supplierPosts[index]["comments"][i]}");
                          }),
                          TextButton(
                            onPressed: () {
                              TextEditingController commentController =
                                  TextEditingController();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Add Comment"),
                                    content: TextField(
                                      controller: commentController,
                                      decoration: InputDecoration(
                                          hintText: "Enter your comment"),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _commentOnPost(
                                              index, commentController.text);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Comment"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Add Comment"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
