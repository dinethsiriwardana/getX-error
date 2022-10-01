import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:timetracker/service/model/data_model.dart';

class SingleLogBox extends StatelessWidget {
  SingleLogBox({Key? key, required this.readdata, required this.position})
      : super(key: key);

  WriteTime readdata;
  int position;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> setupeddata = Map();

    final tval = (readdata.thour + ((readdata.tmin) / 100));
    final cval = (readdata.chour + ((readdata.cmin) / 100));
    datasetup() {
      Color selectpcolor() {
        final ptval = (readdata.thour + ((readdata.tmin) / 100));
        final pcval = (readdata.chour + ((readdata.cmin) / 100));
        final targetbalance = pcval / ptval * 100;
        if (targetbalance >= 100.0) {
          return Colors.amber;
        } else {
          return redColor;
        }
        // return redColor;
      }

      Color selectrankpcolor() {
        if (position == 1) {
          return Colors.amber;
        } else if (position == 2) {
          return lightGreenColor;
        } else if (position == 3) {
          return Colors.blue;
        }
        return white.withOpacity(0.3);
      }

      setupeddata['color'] = selectpcolor();
      setupeddata['rankcolor'] = selectrankpcolor();
      setupeddata['ttime'] =
          "${(readdata.thour <= 9 ? "0${readdata.thour}" : "${readdata.thour}")}.${(readdata.tmin <= 9 ? "0${readdata.tmin}" : "${readdata.tmin}")}";
      setupeddata['ctime'] =
          "${(readdata.chour <= 9 ? "0${readdata.chour}" : "${readdata.chour}")}.${(readdata.cmin <= 9 ? "0${readdata.cmin}" : "${readdata.cmin}")}";
      setupeddata['date'] = "${readdata.docid[6]}${readdata.docid[7]}";
    }

    datasetup();
    // print(setupeddata['color']);
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 75,
      // width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: setupeddata['color'],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Complete - ${setupeddata['ctime']}",
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: white,
                          fontSize: 6.w,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "From - ${setupeddata['ttime']}",
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: white,
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: setupeddata['rankcolor'],
            ),
            child: Center(
              child: Text(
                setupeddata['date'],
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
