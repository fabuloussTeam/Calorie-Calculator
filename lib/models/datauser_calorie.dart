
class DataUserCalories {
   bool genre;
   int age;
   double taille;
   double poids;
   String actSportive;
   double resultat;
   String error = "Veuillez remplir tout les champs SVP";

   DataUserCalories(bool genre, int age, double taille, double poids, String actSportive){
      this.genre = genre;
      this.age = age;
      this.taille = taille;
      this.poids = poids;
      this.actSportive = actSportive;
   }

   calculCalorie(){

     if((age == null) || (taille == null) || (poids == null) || (actSportive == null)){
        return 0.0;
     }

     double f1 = this.poids * this.taille;
     double f2 = f1 / this.age;

     if(f2.isNaN){
       return 0.0;
     }


     return f2;
   }

}