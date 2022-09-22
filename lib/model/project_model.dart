import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    required this.trainsInfo,
    // required this.trainsDistance,
  });

  final List<TrainsInfo> trainsInfo;
  // final List<TrainsDistance> trainsDistance;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    trainsInfo: List<TrainsInfo>.from(json["trainsInfo"].map((x) => TrainsInfo.fromJson(x))),
    // trainsDistance: List<TrainsDistance>.from(json["trainsDistance"].map((x) => TrainsDistance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trainsInfo": List<dynamic>.from(trainsInfo.map((x) => x.toJson())),
    // "trainsDistance": List<dynamic>.from(trainsDistance.map((x) => x.toJson())),
  };

  static List<Project> loadFromDB(List snapshot) {
    return snapshot.map((data) {
      return Project.fromJson(data);
    }).toList();
  }
}

// class TrainsDistance {
//   TrainsDistance({
//     required this.projectId,
//     required this.trainId,
//     required this.trainSpeed,
//     required this.trainDirection,
//     required this.geoPoint,
//     required this.gpsLatitude,
//     required this.gpsLongtitude,
//     required this.targetTrainId,
//     required this.targetGeoPoint,
//     required this.targetGpsLatitude,
//     required this.targetGpsLongtitude,
//     required this.distance,
//   });
//
//   final int projectId;
//   final int trainId;
//   final int trainSpeed;
//   final int? trainDirection;
//   final String? geoPoint;
//   final double gpsLatitude;
//   final double gpsLongtitude;
//   final int targetTrainId;
//   final String? targetGeoPoint;
//   final double targetGpsLatitude;
//   final double targetGpsLongtitude;
//   final double? distance;
//
//   factory TrainsDistance.fromJson(Map<String, dynamic> json) => TrainsDistance(
//     projectId: json["projectID"],
//     trainId: json["trainID"],
//     trainSpeed: json["trainSpeed"],
//     trainDirection: json["trainDirection"],
//     geoPoint: json["geoPoint"],
//     gpsLatitude: json["gpsLatitude"].toDouble(),
//     gpsLongtitude: json["gpsLongtitude"].toDouble(),
//     targetTrainId: json["targetTrainID"],
//     targetGeoPoint: json["targetGeoPoint"],
//     targetGpsLatitude: json["targetGpsLatitude"].toDouble(),
//     targetGpsLongtitude: json["targetGpsLongtitude"].toDouble(),
//     distance: json["distance"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "projectID": projectId,
//     "trainID": trainId,
//     "trainSpeed": trainSpeed,
//     "trainDirection": trainDirection!= null,
//     "geoPoint": geoPoint != null,
//     "gpsLatitude": gpsLatitude,
//     "gpsLongtitude": gpsLongtitude,
//     "targetTrainID": targetTrainId,
//     "targetGeoPoint": targetGeoPoint!= null,
//     "targetGpsLatitude": targetGpsLatitude,
//     "targetGpsLongtitude": targetGpsLongtitude,
//     "distance": distance != null,
//   };
// }

class TrainsInfo {
  TrainsInfo({
    required this.projectId,
    required this.trainId,
    required this.dataTime,
    required this.commTime,
    required this.dataDelay,
    required this.commDelay,
    required this.trainSpeed,
    required this.gpsLatitude,
    required this.gpsLongtitude,
    required this.gpsTime,
    required this.trainDirection,
    required this.tempFreshAir,
    required this.tempBearing,
    required this.camIp,
    required this.thisStationName,
    required this.nextStationName,
    required this.monthlyMilage,
    required this.assetMainName,
    required this.buttonTagId,
    required this.assetMainStatusId,
    required this.rollingStockTypeId,
    required this.anyFault,
  });

  final int projectId;
  final int trainId;
  final DateTime dataTime;
  final DateTime commTime;
  final int dataDelay;
  final int commDelay;
  final int trainSpeed;
  final double gpsLatitude;
  final double gpsLongtitude;
  final DateTime gpsTime;
  final int? trainDirection;
  final int tempFreshAir;
  final int tempBearing;
  final String camIp;
  final String thisStationName;
  final String nextStationName;
  final double monthlyMilage;
  final String assetMainName;
  final int buttonTagId;
  final int assetMainStatusId;
  final int rollingStockTypeId;
  final int anyFault;

  factory TrainsInfo.fromJson(Map<String, dynamic> json) => TrainsInfo(
    projectId: json["projectID"],
    trainId: json["trainID"],
    dataTime: DateTime.parse(json["dataTime"]),
    commTime: DateTime.parse(json["commTime"]),
    dataDelay: json["dataDelay"],
    commDelay: json["commDelay"],
    trainSpeed: json["trainSpeed"],
    gpsLatitude: json["gpsLatitude"].toDouble(),
    gpsLongtitude: json["gpsLongtitude"].toDouble(),
    gpsTime: DateTime.parse(json["gpsTime"]),
    trainDirection: json["trainDirection"],
    tempFreshAir: json["tempFreshAir"],
    tempBearing: json["tempBearing"],
    camIp: json["camIP"],
    thisStationName: json["thisStationName"],
    nextStationName: json["nextStationName"],
    monthlyMilage: json["monthlyMilage"].toDouble(),
    assetMainName: json["assetMainName"],
    buttonTagId: json["buttonTagID"],
    assetMainStatusId: json["assetMainStatusID"],
    rollingStockTypeId: json["rollingStockTypeID"],
    anyFault: json["anyFault"],
  );

  Map<String, dynamic> toJson() => {
    "projectID": projectId,
    "trainID": trainId,
    "dataTime": dataTime.toIso8601String(),
    "commTime": commTime.toIso8601String(),
    "dataDelay": dataDelay,
    "commDelay": commDelay,
    "trainSpeed": trainSpeed,
    "gpsLatitude": gpsLatitude,
    "gpsLongtitude": gpsLongtitude,
    "gpsTime": gpsTime.toIso8601String(),
    "trainDirection": trainDirection,
    "tempFreshAir": tempFreshAir,
    "tempBearing": tempBearing,
    "camIP": camIp,
    "thisStationName": thisStationName,
    "nextStationName": nextStationName,
    "monthlyMilage": monthlyMilage,
    "assetMainName": assetMainName,
    "buttonTagID": buttonTagId,
    "assetMainStatusID": assetMainStatusId,
    "rollingStockTypeID": rollingStockTypeId,
    "anyFault": anyFault,
  };

}

