// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/debugLog/debugcolor.dart';
import 'package:timetracker/screen/loading_screens/custom_loading.dart';
import 'package:timetracker/screen/show_log/log_box.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/get/firebase_get.dart';
import 'package:timetracker/service/model/data_model.dart';
import 'package:timetracker/service/model/datetimemodel.dart';

class LogScreenStream extends StatefulWidget {
  const LogScreenStream({Key? key}) : super(key: key);

  @override
  State<LogScreenStream> createState() => _LogScreenStreamState();
}

int monthData = int.parse(dateTimeNow('MM'));
final GetController getController = Get.put(GetController());

class _LogScreenStreamState extends State<LogScreenStream> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return StreamBuilder<List<WriteTime>>(
      stream: database.readAllDataStream(9), //! Read Data (database.dart)
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          //! Check connection is activer
          if (snapshot.hasData) {
            final mounthData = snapshot.data!.toList();
            // print(mounthData.length);
            if (mounthData.isEmpty) {
            } else {
              Map<String, double> highdate = {};
              int firstMapcount = 0;
              List firstthreelist = [];
              double fullworkhour = 0;

              for (var index = 0; index < mounthData.length; index++) {
                double ptval = (mounthData[index].chour +
                    ((mounthData[index].cmin) / 100));
                highdate[mounthData[index].docid] = ptval;
                fullworkhour = fullworkhour + ptval;
              }
              getController.fullworkhour.value =
                  double.parse((fullworkhour / 100).toStringAsFixed(1));
              // print(getController.fullworkhour.value);
              // print(highdate);

              var formattedMap = Map.fromEntries(highdate.entries.toList()
                ..sort((e1, e2) => e2.value.compareTo(e1.value)));
              print(formattedMap);

              formattedMap.forEach((k, v) {
                if (firstMapcount <= 2) {
                  firstthreelist.add(k);
                }
                firstMapcount++;
              });
              print(firstthreelist);
              return ListView.builder(
                controller: ScrollController(), //! just add this line
                shrinkWrap: true, //! This shit is very important
                itemCount: mounthData.length,
                itemBuilder: (context, index) {
                  int rankindex = 0;
                  for (var i = 0; i <= 2; i++) {
                    if (firstthreelist.length > i) {
                      if (mounthData[index].docid == firstthreelist[i]) {
                        rankindex = i + 1;
                      }
                    }
                  }
                  getController.updateget();
                  return SingleLogBox(
                    readdata: mounthData[index],
                    position: rankindex,
                  );
                },
              );
            }
          }
        }

        if (snapshot.hasError) {
          logError(snapshot.error.toString());
          return const Center(child: CustomLoading());
        }

        return const Center(child: CustomLoading());
      },
    );
  }
}
