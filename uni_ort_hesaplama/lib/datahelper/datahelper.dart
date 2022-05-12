// ignore_for_file: file_names, unused_import, unused_element

import 'package:flutter/material.dart';
import 'package:uni_ort_hesaplama/ders.dart';

class DataHelper{
  static TextEditingController girilenDersAdi1=TextEditingController();
  static List<Ders> tumEklenenDersler=[];
  static dersEkle(Ders ders){
    tumEklenenDersler.add(ders);
    
  }
  
   static double ortalamaHesaplama(){
    double toplamNot=0;
    double toplamKredi=0;
    for (var e in tumEklenenDersler) {
      toplamNot=toplamNot+(e.krediDegeri*e.harfDegeri);
      toplamKredi=toplamKredi+e.krediDegeri;
    }
    return toplamNot/toplamKredi;
  }
  static List<String> _tumDerslerinHarfleri(){
    return ["AA","BA","BB","CB","CC","DC","DD","FD","FF"];
  }
  static double _harfiNotaCevir(String harf){
    switch (harf){
      case "AA":
      return 4;
    }
    switch (harf){
      case "BA" : 
      return 3.5;
    }
    switch (harf){
      case "BB":
      return 3;
    }
     switch (harf){
      case "CB":
      return 2.5;
    }
     switch (harf){
      case "CC":
      return 2;
    }
     switch (harf){
      case "DC":
      return 1.5;
    }
     switch (harf){
      case "DD":
      return 1;
    }
     switch (harf){
      case "FD":
      return 0.5;
    }
     switch (harf){
      case "FF":
      return 0;
      default :
      return 1;
    }  
  }
  static List<DropdownMenuItem<double>> tumDerslerinHarfleri(){
    return _tumDerslerinHarfleri().map((e) => DropdownMenuItem(child: Text(e),
    value: _harfiNotaCevir(e),
    ),
    ).toList();
  }
  static List<double> _tumDerslerinKredileri(){
    return [1,2,3,4,5,6,7,8,9,10];
  }
  static List<DropdownMenuItem<double>> tumDerslerinKredileri(){
    return _tumDerslerinKredileri().map((e) => DropdownMenuItem(child: Text(e.toStringAsFixed(0),),
    value: e,
    ),).toList();
    
  }
}