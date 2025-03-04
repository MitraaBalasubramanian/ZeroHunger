import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _postController = TextEditingController();
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _posts = [];

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _addPost() {
    if (_postController.text.isEmpty) return;

    setState(() {
      _posts.insert(0, {
        "content": _postController.text,
        "date": _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : "No Date",
        "likes": 0,
        "comments": [],
      });
      _postController.clear();
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("ZeroHunger"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // OpenStreetMap Section
          Container(
            height: 250,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(13.0520, 80.2205),
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),

          // Create Post Section
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // Text Field
                TextField(
                  controller: _postController,
                  decoration: InputDecoration(
                    hintText: "Create a post...",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),

                // Post Options (Photo/Video, Date)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _optionButton(Icons.image, "Photo/Video", () {
                      // Add image upload logic here
                    }),
                    _optionButton(Icons.date_range, "Select Date", _pickDate),
                  ],
                ),

                // Post Button
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(double.infinity, 40),
                  ),
                  child: Text("Post", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // Feed Section
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return _postCard(_posts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Post Options Widget
  Widget _optionButton(IconData icon, String text, VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(color: Colors.white)),
      style: TextButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  // Post Card Widget
  Widget _postCard(Map<String, dynamic> post) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Anonymous User",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(post["content"]),
            if (post["date"] != "No Date")
              Text("📅 ${post["date"]}", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconTextButton(Icons.thumb_up, "Like", () {
                  setState(() {
                    post["likes"]++;
                  });
                }),
                _iconTextButton(Icons.comment, "Comment", () {
                  // Add comment logic here
                }),
                _iconTextButton(Icons.chat, "Chat", () {
                  Navigator.pushNamed(context, '/chat');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Like, Comment, Chat Buttons
  Widget _iconTextButton(IconData icon, String text, VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.teal),
      label: Text(text, style: TextStyle(color: Colors.teal)),
    );
  }
}
