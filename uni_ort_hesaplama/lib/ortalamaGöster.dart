// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:uni_ort_hesaplama/sabitler.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;

  const OrtalamaGoster({Key? key, required this.ortalama, required this.dersSayisi}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text(dersSayisi>0 ? "$dersSayisi Ders Girildi" : "Ders Seçiniz ",
      style: Sabitler.dersSayisiStyle,
      ),
      Text(ortalama>=0 ? ortalama.toStringAsFixed(2): "0.0",style: Sabitler.ortalamaStyle,),
      Text("Ortalama",style: Sabitler.dersSayisiStyle,)
    ],
      
      
    );
  }
}