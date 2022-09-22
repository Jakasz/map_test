import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrainCard extends StatelessWidget {
  const TrainCard(
      {Key? key,
      required this.trainId,
      required this.time1,
      required this.time2,
      required this.trainStationName})
      : super(key: key);
  final int trainId;
  final String time1;
  final String time2;
  final String trainStationName;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Card(
        color: Colors.brown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Image(
                    image: AssetImage('assets/ukraine.png'),
                    width: 20,
                    height: 20,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Text(
                      trainId.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(trainStationName, style: TextStyle(color: Colors.white)),
              ],
            ),
            Align(
                alignment: Alignment.center,
                child: Text(parseDate(time1),
                    style: const TextStyle(color: Colors.white))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(parseDate(time2),
                      style: const TextStyle(color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }

  parseDate(String time) {
    var currTime = DateTime.parse(time);
    return DateFormat('HH:mm:ss').format(currTime);
  }
}
