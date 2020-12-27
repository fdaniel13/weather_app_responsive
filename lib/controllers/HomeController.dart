import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/models/Weather.model.dart';
import 'package:weather_app/models/WeatherData.model.dart';
import 'package:weather_app/models/Coord.model.dart';
import 'package:weather_app/models/Clouds.model.dart';
import 'package:weather_app/models/Main.model.dart';
import 'package:weather_app/models/Sys.model.dart';
import 'package:flutter/material.dart';

class HomeController{
   static WeatherData w ;
   static Coord c;
   static Sys s;
   static Main m ;
   static Clouds cl;
   static Weather we;


   static bool apiON=false;



   static callApi() async{
    if(apiON==false){

      var lat= -5.08921;
      var lon=-42.8016;
      var apiId='';
      String url = "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiId}&units=metric";
      http.Response resp;

      resp = await  http.get(url);
      Map<String,dynamic> data =  convert.jsonDecode(resp.body);



      HomeController.c= new Coord.fromJson(data['coord']);

      HomeController.m = new Main.fromJson(data['main'])  ;
      HomeController.cl =  new Clouds.fromJson(data['clouds']);
      HomeController.we =  new Weather.fromJson(data['weather'][0]);
      HomeController.s = new Sys.fromJson(data['sys']);
      HomeController.w = new WeatherData.fromJson(data);

        apiON=true;




    }


    }

  }

