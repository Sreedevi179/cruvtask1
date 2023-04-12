import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ContainerModel {
  final String text;
  final int number;
  bool isSearched;

  ContainerModel({required this.text, required this.number, this.isSearched = false});
}
class TrainSeats extends StatefulWidget {
  @override
  _TrainSeatsState createState() => _TrainSeatsState();
}

class _TrainSeatsState extends State<TrainSeats> {
  List<ContainerModel> containers = List.generate(32, (index) => ContainerModel(text: '$index', number: index));
  int searchIndex = -1;

  void search(int index) {
    setState(() {
      searchIndex = index;
    });
  }
  void _search(String query) {
    setState(() {
      containers.forEach((container) {
        container.isSearched = container.text.contains(query);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Seat Finder',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.lightBlueAccent)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0,top: 36.0,right: 36.0,bottom: 0.0),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: _search,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    hintText: 'Enter Seat Number', suffixIcon: Icon(Icons.search,)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child : GridView.builder(
                    //itemCount: containers.length,
                    itemCount: 32,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      String text = '';
                      bool isOddRow = (index ~/ 4) % 2 == 0;
                      //bool isColumn = (index ~/ 4) % 10 == 0;
                      double crossAxisSpacing = 0.0;
                      double mainAxisSpacing = 0.0;
                      if(index==2 ||index==6 ||index==10 ||index==14 ||index==18 || index==22 ||index==26 ||index==30){
                        crossAxisSpacing=24.0;
                      } else {
                        crossAxisSpacing=0.0;
                      }
                      if(index==0 ||index==1 ||index==2 ||index==3 ||index==8 || index==9 ||index==10 ||index==11 || index==16 || index==17 || index==18 || index==19 ||index==24 || index==25 || index==26 || index==27){
                        mainAxisSpacing=24.0;
                      } else {
                        mainAxisSpacing=0.0;
                      }

                      if (isOddRow) {
                        switch (index % 4) {
                          case 0:
                            text = 'LOWER';
                            break;
                          case 1:
                            text = 'MIDDLE';
                            break;
                          case 2:
                            text = 'UPPER';
                            break;
                          case 3:
                            text = 'SIDE LOWER';
                            break;
                        }
                      } else {
                        switch (index % 4) {
                          case 0:
                            text = 'LOWER';
                            break;
                          case 1:
                            text = 'MIDDLE';
                            break;
                          case 2:
                            text = 'UPPER';
                            break;
                          case 3:
                            text = 'SIDE UPPER';
                            break;
                        }
                      }
                      if(isOddRow){
                        switch (index%8) {
                          case 0:
                            index = index+1;
                            break;
                          case 1:
                            index = index+1;
                            break;
                          case 2:
                            index = index+1;
                            break;
                          case 3:
                            index = index+4;
                            break;
                        }
                      }
                      else {
                        switch (index%8) {
                          case 0:
                            index = index;
                            break;
                          case 1:
                            index = index;
                            break;
                          case 2:
                            index = index;
                            break;
                          case 3:
                            index = index+6;
                            break;
                        }
                      }
                      int number = index;
                      final container = containers[index];
                      return Center(
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Train Seat Details', style: TextStyle(color:Colors.blue,fontSize: 20),),
                                          insetPadding: EdgeInsets.symmetric(horizontal: 100,vertical: 220),
                                          content: Container(
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Berth Type :$text',
                                                    style: TextStyle(color:Colors.black,fontSize: 16),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    'Seat Number :$number',
                                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: Text('Close'),
                                              onPressed: () {
                                                Navigator.of(context).pop(); // close the popup container
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child : Container(
                                      margin: EdgeInsets.only(right: crossAxisSpacing,bottom: mainAxisSpacing),
                                        height: 64,
                                        width: 64,
                                        color: container.isSearched ? Colors.blueAccent : Colors.lightBlueAccent,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                text,
                                                style: TextStyle(color: container.isSearched ? Colors.white : Colors.blueAccent,fontSize: 8),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                '$number',
                                                style: TextStyle(color: container.isSearched ? Colors.white : Colors.blueAccent, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                ),
                              );
                    },
                  ),
              ),
            ),
          ],
        ),
      );
  }
}

