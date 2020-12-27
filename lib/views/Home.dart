


import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/controllers/HomeController.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class  _HomeState extends State<Home> {

  bool apiFinish = false;
  var data;

   setData() async{
    return await HomeController.callApi();


  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future:  HomeController.callApi(),
        builder: (context,snapshot){

          var oriet =MediaQuery.of(context).orientation;
          var sizeW =MediaQuery.of(this.context).size.width;
          var sizeH = MediaQuery.of(this.context).size.height;
          var w;
          var size = oriet==Orientation.landscape?sizeH:sizeW;

          if(snapshot.connectionState==ConnectionState.done) {

            w=HomeController.w;

            return Scaffold(

              body: Container(
                width: sizeW,
                height: sizeH,
                color: Color(0xff37C6C8),
                // padding: EdgeInsets.all(1),
                child: LayoutBuilder(

                    builder: (_, constraints) {
                      return Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: size * 0.1,
                                bottom: size * 0.1),
                            child: Row(
                              mainAxisAlignment: oriet == Orientation.landscape
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                Text(
                                  w == null ? 'Localização  ' : '${w.name}-${w
                                      .sys.country}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size * 0.04
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: sizeW,
                            height: sizeH,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('images/Temperature.svg',
                                  width: size * 0.6,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: sizeW,
                            height: sizeH,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('images/tela.svg',
                                  width: size * 0.5,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              width: sizeW,
                              height: sizeH,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    w == null ? '${oriet}max e min' : 'max:${w
                                        .main.tempMax}°C min:${w.main
                                        .tempMin}°C',

                                    style: TextStyle(
                                      color: Color(0XFF1D1B1B),
                                      height: size * 0.02,
                                      fontSize: size * 0.03,

                                    ),
                                  ),
                                  Text(
                                    w == null ? 'Localização' : '${w.main
                                        .temp} °C',
                                    style: TextStyle(
                                      color: Color(0XFF1D1B1B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: size * 0.07,

                                    ),
                                  ),
                                  Image.network(w == null
                                      ? 'http://openweathermap.org/img/wn/01d@2x.png'
                                      : 'http://openweathermap.org/img/wn/${w
                                      .weather[0].icon}@2x.png',
                                    scale: 1,
                                  )
                                ],
                              )

                          )
                        ],
                      );
                    }
                ),

              ),
            );
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return Scaffold(
              body: Container(
                width: sizeW,
                height: sizeH,
                color: Color(0xff37C6C8),
                child: Center(
                  child: Text(
                    'Fetching Data...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
         }
        );
  }
}
