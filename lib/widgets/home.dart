import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'custom_text.dart';
import 'package:challengecalculateurcalorie/models/datauser_calorie.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  bool genre = false;
  double maTailleSlider = 0.0;
  double votrePoid;
  double poidchanged;
  double poidsubmitted;
  int activiteSportive;
  Map activiteSportiveList = {};
  int age;
  DateTime date;
  DateTime dateactuelle = new DateTime.now();
  String itemSelectionne;
  int itemkeyselectionne;
  double actualYear;
  double beforeYear;
  double currentAge;

  DataUserCalories dataUserCalories;

  int calorieBase;
  int calorieAvecActiviter;

  BuildContext buildContext;

  @override
  void initState(){
    super.initState();
    genre = false;
    date = null;
    age = null;
    maTailleSlider = 0.0;
    poidchanged = null;
    poidsubmitted = null;
    //activiteSportive = 0;
    activiteSportiveList = {
      1: "Faible",
      2: "Modere",
      3: "Fort"
    };

    dataUserCalories = new DataUserCalories(
        (genre == true) ? true : false,
        (age == null) ? 0 : age,
        (maTailleSlider != 0.0) ? maTailleSlider: 0.0,
        (poidsubmitted == null) ? 0.0 : poidsubmitted,
        (itemSelectionne == null) ? "" : itemSelectionne,
    );

  }

  @override
  Widget build(BuildContext context) {
    
    double cardHeigth = MediaQuery.of(context).size.height;
   // print(dateactuelle.year);
   // print();
    List<DataUserCalories> objectdata = [
      new DataUserCalories(
        genre,
        age,
        maTailleSlider,
        poidsubmitted,
        itemSelectionne,
      ),
    ];

double resultDialog = objectdata[0].calculCalorie();

   return new GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: (genre == false) ? Colors.pinkAccent : Colors.blue,
              title: Text(widget.title),
            ),
          body: new SingleChildScrollView(
            // in the middle of the parent.
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  padding(),
                  new CustomText(
                    "Remplissez tous les champs pour obtenir votre besoin journalier en calories",
                    color: Colors.grey[900],
                    factor: 1.1,
                  ),
                  padding(),
                  new Card(
                  //  margin: EdgeInsets.only(top: 10),
                    elevation: 20,
                    color: Colors.white,
                    child: new Container(
                      width: cardHeigth / 1.8,
                    //  height: cardHeigth / 1.6,

                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             new CustomText("Femme", color: Colors.pinkAccent,),
                             new Switch(
                                 value: genre,
                                 inactiveTrackColor: Colors.pinkAccent,
                                 onChanged: (bool g){
                                   setState(() {
                                     genre = g;
                                   });
                                 }
                             ),
                             new CustomText("Homme", color: Colors.blue,)
                           ],
                          ),
                         padding(),
                          new RaisedButton(
                            onPressed: currentAgeSelect,
                            color: (genre == false) ? Colors.pinkAccent : Colors.blue,
                              child: new CustomText(
                                (age == null) ? "Appuyer pour entrer votre age" : "Vous avez $age ans",
                                 color: Colors.white,
                              ),
                          ),
                          padding(),
                          new CustomText(
                             "Votre taille est de ${maTailleSlider.toInt()} Mètre",
                              color:  (genre == false) ?  Colors.pinkAccent : Colors.blue
                          ),
                          padding(),
                          new Slider(
                              value: maTailleSlider,
                              min: 0.0,
                              max: 215.0,
                              activeColor: (genre == false) ? Colors.pinkAccent : Colors.blue,
                              onChanged: (double matailleActuelle){
                                setState(() {
                                  maTailleSlider = matailleActuelle;
                                });
                              }
                          ),
                          padding(),
                          new Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (String b){
                                setState(() {
                                  poidchanged = double.tryParse(b);
                                  print("sorti de poid: $poidchanged");

                                });
                              },
                              onSubmitted: (String b){
                                setState(() {
                                  poidsubmitted = double.tryParse(b);
                               //   print("sorti de poid: $poidsubmitted");
                                });

                              },
                              decoration: new InputDecoration(
                                  labelText: "Entrez votre poids"
                              ),
                            ),
                          ),
                          padding(),
                          new CustomText("Quelle est votre activité Sportive?", color: (genre == false) ? Colors.pinkAccent : Colors.blue),
                          padding(),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: activiteSportives(),
                          ),
                          padding(),
                        ],
                      ),
                    ),
                  ),
                  padding(),
                  new RaisedButton(
                     onPressed: CalculerNombreCalories,
                     child: new CustomText("Calculer"),
                     color: (genre == false) ? Colors.pinkAccent : Colors.blue,
                  ),
                ],
              ),
            )
          ),
        );

  }

  // Fonction de changement de couleur
  setColors(){
    if(genre){
      return Colors.blue;
    } else {
      return Colors.pinkAccent;
    }
  }

  // Fonction pour la faire un espace : Functionne que dans les childs
  padding(){
    return new Padding(padding: EdgeInsets.only(top: 20.0));
  }


  // Widget d'affichage des activitées sportive

  List<Widget> activiteSportives(){
    List<Widget> l = [];
    activiteSportiveList.forEach((key, value){
      Row row = new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Radio(
                   activeColor: setColors(),
                    value: value,
                    groupValue: itemSelectionne,
                    onChanged: (Object i){
                      setState(() {
                        itemSelectionne = i;
                        itemkeyselectionne = key;
                      });
                     print(itemSelectionne);
                     print(itemkeyselectionne);
                    }
                ),
                new CustomText(value, color: setColors())
              ]
          ),
        ],
      );
      l.add(row);
    });
    return l;
  }

  // Calculer de l'age
  Future<Null> currentAgeSelect() async{

    DateTime choix = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
    );

    // Solution de la correction
    if (choix != null){
      var difference = new DateTime.now().difference(choix);
      print("diffrence de date: $difference");
      var jours = difference.inDays;
      print("age en jours c'est: $jours");

      var ans =  jours / 365;
      print("Age en années c'est: $ans");
    }

      setState(() {
        date = choix;
        if(dateactuelle.year > date.year){
        age = dateactuelle.year - date.year;
        }
      });

}


  // Function d'allerte si tous les chanps ne sont pas remplits

void CalculerNombreCalories(){
    if(age != null && poidchanged != null && itemSelectionne != null){

      if(genre){
        calorieBase = (66.4730 + (13.7516 * poidchanged) + (5.0023 * maTailleSlider) - (6.7550 * age)).toInt();
        print("calcul pour homme $calorieBase");
      } else {
        calorieBase = (655.0955 + (95624 * poidchanged) + (1.8496 * maTailleSlider) - (4.6756 * age)).toInt();
        print("calcul pour femme $calorieBase");
      }

      switch(itemkeyselectionne){
        case 1:
          calorieAvecActiviter = (calorieBase * 1.2).toInt();
          print(calorieAvecActiviter);
          break;
        case 2:
          calorieAvecActiviter = (calorieBase * 1.2).toInt();
          break;
        case 3:
          calorieAvecActiviter = (calorieBase * 1.2).toInt();
          break;
        default:
          calorieAvecActiviter = calorieBase;
          break;
      }
      setState(() {
        dialogue();
      });
    } else {
      alerte();
    }
}


// Affihage de notre simple dialog
  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible:  false,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            title: new CustomText("Votre besoin en calorie", color: setColors()),
            contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              padding(),
              new CustomText("Votre besoin de base est de $calorieBase", color: Colors.grey[800]),
              padding(),
              new CustomText("Votre besoin avec activité sportive est de : $calorieAvecActiviter", color: Colors.grey[900]),
              new RaisedButton(onPressed: (){
                Navigator.pop(buildContext);
              },
                child: new CustomText("OK", color: Colors.white),
                color: setColors(),
              )
            ],
          );
        }
    );
  }


// Alerte pour les champ quine sont pas remplit
  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Erreur', textScaleFactor: 1.5,),
            content: new Text("Tous les champs ne sont pas remplis"),
            contentPadding: EdgeInsets.all(5.0),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: new Text("Ok", style: new TextStyle(color: Colors.blue) ,)
              )
            ],
          );
        }
    );
  }






}