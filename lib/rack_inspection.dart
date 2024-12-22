import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RackInspection extends StatefulWidget {
  const RackInspection({super.key});

  @override
  State<RackInspection> createState() => _RackInspectionState();
}

class _RackInspectionState extends State<RackInspection> {
  List lineList = [];
  Map<String, dynamic> racks = {};

  @override
  void initState() {
    getRack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rack Inspection"),
      ),
      body: lineList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _buildWidgetTree(),
        ),
      ),
    );
  }

  /// Builds the widget tree dynamically
  Widget _buildWidgetTree() {
    final root = lineList.firstWhere((element) => element['side_by'] == "0");
    return _buildWidget(root, lineList);
  }

  /// Recursively builds widgets
  /// Recursively builds widgets with horizontal layout
  Widget _buildWidget(Map<String, dynamic> current, List data) {
    // Find child widgets where side_by matches the current widget's id
    final children = data.where((item) => item['side_by'] == current['id']).toList();

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current widget container
          _buildContainer(current['id'], Colors.orange),

          // Child widgets
          if (children.isNotEmpty)
            ...children.map((child) {
              return _buildChildWidget(child, data);
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildChildWidget(Map<String, dynamic> child, List data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recursive call for child widgets
        _buildWidget(child, data),
      ],
    );
  }


  /// Positions the child widgets
  Widget _positionChild(Map<String, dynamic> child, List data, int index) {
    Widget childWidget = _buildWidget(child, data);

    const double spacing = 150.0; // Adjust spacing

    switch (child['direction']) {
      case 'Right':
        return Positioned(
          left: spacing * (index + 1),
          top: 0,
          child: childWidget,
        );
      case 'Left':
        return Positioned(
          right: spacing * (index + 1),
          top: 0,
          child: childWidget,
        );
      case 'Top':
        return Positioned(
          top: -spacing * (index + 1),
          left: 0,
          child: childWidget,
        );
      case 'Bottom':
        return Positioned(
          bottom: -spacing * (index + 1),
          left: 0,
          child: childWidget,
        );
      default:
        return childWidget;
    }
  }

  /// Builds a container for each rack
  Widget _buildContainer(String name, Color color) {
    if (!racks.containsKey(name) || racks[name].isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: color.withOpacity(0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(racks[name].length, (index) {
          var items = racks[name][index];
          List columnList = jsonDecode(items['column_name']);

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(columnList.length, (columnIndex) {
                List levelList = columnList[columnIndex]['levels'];

                return Column(
                  children: [
                    ...List.generate(levelList.length, (levelIndex) {
                      return Container(
                        height: 50,
                        width: 80,
                        margin: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          levelList[levelIndex]['name'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }),
                    Container(
                      height: 50,
                      width: 80,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        columnList[columnIndex]['name'],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  /// Fetches rack data
  getRack() async {
    var response = await http.get(
      Uri.parse("https://codinghouse.in/RackInspection/project/get_racks/32"),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      setState(() {
        lineList = responseData['lines'];
        racks = responseData['racks'];
      });
    } else {
      print("Failed to fetch data");
    }
  }
}
