// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:uni_ort_hesaplama/datahelper/dataHelper.dart';
import 'package:uni_ort_hesaplama/ders.dart';

import 'package:uni_ort_hesaplama/ortalamaG%C3%B6ster.dart';
import 'package:uni_ort_hesaplama/sabitler.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "4'lük Sistemde Ortalama Hesaplama",
      theme: ThemeData(
        backgroundColor: Sabitler.anaRenk,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Ortalama(),
    );
  }
}
class Ortalama extends StatefulWidget {
  const Ortalama({ Key? key }) : super(key: key);

  @override
  State<Ortalama> createState() => _OrtalamaState();
}

class _OrtalamaState extends State<Ortalama> {
  var formkey=GlobalKey<FormState>();
  double secilenHarfDegeri=4;
  double secilenKrediDegeri=1;
  String girilenDersAdi="";
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, //ekranin tamamiyle kaplamasını sağlar
            image: AssetImage("assets/bac1.jpg")),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent ,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(Sabitler.baslikText,
          style: Sabitler.baslikStyle, 
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Expanded(
                flex: 2,
                child: buildForm(),),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(ortalama: DataHelper.ortalamaHesaplama(), dersSayisi: DataHelper.tumEklenenDersler.length)),
            ],),
        Expanded(child: dersListesi()
        ),
        ],),
        
        
      ),
    );
  }
  Widget buildForm(){
    return Form(
      
      key: formkey,
      child: Column(children: [
        _buildTextFormField(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          _buildHarfler(),
          _buildKrediler(),
          IconButton(onPressed: _dersSecimiveOrtalamaHesapla, icon: Icon(Icons.add_box_outlined),
          iconSize: 30,color: Colors.white,
          )
        ],)
      ],));
  }

  _buildTextFormField() {
    return TextFormField(
      cursorColor: Colors.white,
      onSaved: (e){
        setState(() {
          girilenDersAdi=e!;
        });
        
      },
      controller: DataHelper.girilenDersAdi1,

      validator: (a){
        if(a!.isEmpty){
          return "Ders Adini giriniz";
        }
        else{
          return null;
        }
      },
      decoration: InputDecoration(
        
        hintText: "Ders Adı Girin",
        border: OutlineInputBorder(
          
          borderRadius: Sabitler.borderRadius
          ),
          ),
    );
  }

  _buildHarfler() {
    
    return Container(
      padding: Sabitler.dropdownButtonpading,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double?>(
      value: secilenHarfDegeri,
        items: DataHelper.tumDerslerinHarfleri(),
        onChanged: (deger){
          setState(() {
            secilenHarfDegeri=deger!;
          });
          
        },
      )
    );
  }
    _buildKrediler() {
    
    return Container(
      padding: Sabitler.dropdownButtonpading,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double?>(
      value: secilenKrediDegeri,
        items: DataHelper.tumDerslerinKredileri(),
        onChanged: (deger){
          setState(() {
            secilenKrediDegeri=deger!;
          });
          
        },
      )
    );
  }

  


  void _dersSecimiveOrtalamaHesapla() {
    
    if(formkey.currentState!.validate()){
      var _eklenecekDers=Ders(
        ad: DataHelper.girilenDersAdi1.text, 
        harfDegeri: secilenHarfDegeri,
        krediDegeri: secilenKrediDegeri);
     print(_eklenecekDers.ad);
     DataHelper.dersEkle(_eklenecekDers);
     setState(() {
       
     });
    }
  }

  dersListesi() {
    return ListView.builder(itemCount: DataHelper.tumEklenenDersler.length,itemBuilder: ((context, index) {
        return DataHelper.tumEklenenDersler.isNotEmpty ? Dismissible(
          key: UniqueKey(),
          onDismissed: (a){
            setState(() {
              DataHelper.tumEklenenDersler.removeAt(index);
            });
          },
          child: Card(
            child: ListTile(
              title: Text(DataHelper.tumEklenenDersler[index].ad),
              subtitle: Text("${DataHelper.tumEklenenDersler[index].krediDegeri} Kredi,Notu: ${DataHelper.tumEklenenDersler[index].harfDegeri}"),
              leading: CircleAvatar(
                child: Text(DataHelper.tumEklenenDersler[index].ad),
              ),
            ),
          ),
        ) : Container(child: Text("Lütfen Ders Girin"));
      }));
  }
 
}