import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/services/project_service.dart';
import 'package:untitled/services/token_service.dart';
import 'package:untitled/wigets/train_card.dart';

import '../model/project_model.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final CameraPosition _cam =
  const CameraPosition(target: LatLng(50.392660, 30.506431), zoom: 15.5);
  static const _projects = [1, 2, 3, 4, 5];
  List<Project> _projectData = [];
  String _token = "";
  bool _isLoading = true;
  late GoogleMapController _mapController;
  late  List<Marker> _markers = [];
  final Marker _initMarker = const Marker(
      markerId: MarkerId('initPlace'),
      position: LatLng(50.432474, 30.651875),
      infoWindow: InfoWindow(title: "initPlace"));

  @override
  void initState() {
    getProjectValues(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
                markers: _markers.isNotEmpty ? Set<Marker>.of(_markers) : {
                  _initMarker
                },
                initialCameraPosition: _cam,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (controller) => _mapController = controller),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.red,
                  )
                      : SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _projects.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 100,
                            child: Opacity(
                              opacity: 0.8,
                              child: GestureDetector(
                                onTap: (){
                                  setProject(index+1);
                                },
                                child: Card(
                                  color: Colors.brown,
                                  child: ListTile(
                                    title: Text("Pr. ${_projects[index].toString()}"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.red,
                  )
                      : SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _projectData[0].trainsInfo.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 120,
                            child: GestureDetector(
                              onTap: () {
                                _mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(target:
                                        LatLng(
                                            _projectData[0].trainsInfo[index]
                                                .gpsLatitude,
                                            _projectData[0].trainsInfo[index]
                                                .gpsLongtitude),
                                        zoom: 11.5)));
                              },
                              child: TrainCard(
                                  trainId: _projectData[0]
                                      .trainsInfo[index]
                                      .trainId,
                                  time1: _projectData[0]
                                      .trainsInfo[index]
                                      .dataTime
                                      .toString(),
                                  time2: _projectData[0]
                                      .trainsInfo[index]
                                      .commTime
                                      .toString(),
                                  trainStationName: _projectData[0]
                                      .trainsInfo[index]
                                      .thisStationName),
                            ),
                          );
                        }),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void getProjectValues(int projectId) async {
    try {
      if (_token == "") {
        _token = await getTokenFromNet();
      }
      _projectData = await ProjectService().getData(projectId, _token);
      fillMarkers();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void setProject(int projectId){
    _projectData = [];
    _markers = [];
    setState(() {
      _isLoading = true;
    });
    getProjectValues(projectId);
  }

  void fillMarkers() {
    for (var i = 0; i < _projectData[0].trainsInfo.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(_projectData[0].trainsInfo[i].trainId.toString()),
          position: LatLng(_projectData[0].trainsInfo[i].gpsLatitude,
              _projectData[0].trainsInfo[i].gpsLongtitude),
          infoWindow:
          InfoWindow(title: _projectData[0].trainsInfo[i].assetMainName)));
    }
  }

  getTokenFromNet() async {
    var tokenObj =
    await TokenService().getData("someEmail@ukr.net", "12345678");
    return tokenObj[0].token;
  }
}
