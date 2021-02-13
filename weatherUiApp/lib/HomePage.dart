import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://api.openweathermap.org/data/2.5/';
  var data;
  String typeOfWeather;
  double degree;
  double feelsLike;
  int pressure;
  int humidity;
  double minTemp;
  int id = 1273294;
  double maxTemp;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String city = 'Delhi';
  String country;
  var hourlyData;
  double windSpeed;

  Future<String> weatherJson() async {
    var newUrl =
        url + 'weather?q=' + city + '&appid=4187cfb45358eb0a570b1e216b9b127f';
    var response = await http.get(newUrl);
    print(response.statusCode);
    setState(() {
      var jsonData = jsonDecode(response.body);
      data = jsonData;
      typeOfWeather = data['weather'][0]['main'];
      degree = data['main']['temp'];
      feelsLike = data['main']['feels_like'];
      minTemp = data['main']['temp_min'];
      maxTemp = data['main']['temp_max'];
      pressure = data['main']['pressure'];
      humidity = data['main']['humidity'];
      country = data['name'];
      city = data['name'];
      id = data['id'];
      windSpeed = data['wind']['speed'];
      print(data);
    });
    return 'Sucess';
  }

  bool isSearchClicked = false;

  Future<String> hourlyJson() async {
    String urlNew = url +
        'forecast?id=' +
        id.toString() +
        '&appid=4187cfb45358eb0a570b1e216b9b127f';
    print(urlNew);
    var response = await http.get(urlNew);
    setState(() {
      var jsonData = jsonDecode(response.body);
      hourlyData = jsonData;
      print(hourlyData);
    });
    return 'Sucess';
  }

  int i = 2;

  void showModalSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.grey.withOpacity(0.2),
        elevation: 10,
        context: context,
        builder: (context) {
          return Container(
              clipBehavior: Clip.antiAlias,
              height: MediaQuery.of(context).size.height * 0.34,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(
                  22,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.fromLTRB(12, 12, 12, 1),
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.black,
                                width: 1.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  color: Colors.black,
                                ),
                                Text(
                                  (minTemp - 273.15).round().toString() +
                                      '/' +
                                      (maxTemp - 273.15).round().toString() +
                                      '°C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Temperature',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.fromLTRB(12, 12, 12, 1),
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.black,
                                width: 1.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  color: Colors.black,
                                ),
                                Text(
                                  windSpeed.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Wind',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.fromLTRB(12, 12, 12, 1),
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.black,
                                width: 1.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  color: Colors.black,
                                ),
                                Text(
                                  humidity.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.fromLTRB(12, 12, 12, 1),
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.black,
                                width: 1.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  color: Colors.black,
                                ),
                                Text(
                                  pressure.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Pressure',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ));
        });
  }

  TextEditingController _controller;

  showAlert() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Container(
              margin: EdgeInsets.fromLTRB(
                20,
                60,
                20,
                50,
              ),
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[800],
                  width: 1.2,
                ),
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(
                  9,
                ),
              ),
              child: Material(
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(
                          color: Colors.black,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          DateTime.now().toIso8601String().split('T')[0] ==
                                  hourlyData['list'][i]['dt_txt']
                                      .toString()
                                      .split(' ')[0]
                              ? 'Today'
                              : 'Tommorow',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        subtitle: Text(
                          hourlyData['list'][i]['dt_txt']
                              .toString()
                              .split(' ')[1],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          (hourlyData['list'][i]['main']['temp_max'] - 273.15)
                                  .round()
                                  .toString() +
                              '/' +
                              (hourlyData['list'][i]['main']['temp_min'] -
                                      273.15)
                                  .round()
                                  .toString() +
                              '°C',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    setState(
      () {
        weatherJson();

        if (id != null) {
          print(id);
          hourlyJson();
        }
        print(isSearchClicked);
        if (data != null) {
          print(data);
        }
        // if (hourlyData != null) {
        //   print(hourlyData);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.amberAccent.shade50,
      body: hourlyData == null
          ? Container(
              color: Colors.grey[800],
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[100],
                  valueColor: AlwaysStoppedAnimation(Colors.orange),
                ),
              ),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.redAccent.shade400,
                  width: 1.4,
                ),
                borderRadius: BorderRadius.circular(
                  8,
                ),
                image: DecorationImage(
                  image: AssetImage('images/image$i.jpg'),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.grey[600],
                    BlendMode.hardLight,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  isSearchClicked == false
                      ? Positioned(
                          top: 35,
                          left: 25,
                          child: AnimatedContainer(
                            curve: Curves.bounceInOut,
                            duration: Duration(
                              milliseconds: 100,
                            ),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600],
                                  blurRadius: 1.9,
                                  spreadRadius: 1.4,
                                )
                              ],
                              border: Border.all(
                                color: Colors.grey[700],
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.grey[800],
                                ),
                                onPressed: () {
                                  setState(() {
                                    hourlyJson();
                                    showAlert();
                                    print('Menu CLicked');
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          top: 20,
                          left: 14,
                          child: AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(
                              microseconds: 100,
                            ),
                            // padding: EdgeInsets.all(6),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.86,
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                city = value;
                              },
                              controller: _controller,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[800],
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Search',
                                labelStyle: TextStyle(
                                  color: Colors.purple[800],
                                  fontSize: 18,
                                ),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.grey[800],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isSearchClicked = !isSearchClicked;
                                    });
                                  },
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey[800],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      data = null;

                                      weatherJson();
                                      i = Random().nextInt(8) + 1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                  isSearchClicked == false
                      ? Positioned(
                          top: 35,
                          right: 25,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600],
                                  blurRadius: 1.9,
                                  spreadRadius: 1.4,
                                )
                              ],
                              border: Border.all(
                                color: Colors.grey[700],
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.search),
                                color: Colors.grey[700],
                                onPressed: () {
                                  setState(() {
                                    isSearchClicked = !isSearchClicked;
                                    print(isSearchClicked);
                                    print('Search CLicked');
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    top: 80,
                    left: MediaQuery.of(context).size.width * 0.34,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        country,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                'fonts/Kufam-Italic-VariableFont_wght.ttf',
                            fontSize: 46,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 1.2,
                            letterSpacing: 1.1,
                            shadows: [
                              Shadow(
                                blurRadius: 2,
                                offset: Offset(2, 1),
                                color: Colors.grey[700],
                              ),
                            ]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: MediaQuery.of(context).size.width * 0.40,
                    child: Text(
                      (degree - 273.15).round().toString() + '°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(
            Icons.more_horiz,
            color: Colors.grey[600],
          ),
        ),
        backgroundColor: Colors.grey[200],
        onPressed: () {
          setState(() {
            print('More');
            showModalSheet();
          });
        },
      ),
    );
  }
}
