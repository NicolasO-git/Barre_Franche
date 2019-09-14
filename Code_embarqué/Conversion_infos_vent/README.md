# Conversion infos vent

Cette fonction utilise deux dispositif électronique :
## Un anémomètre numérique qui nous permettra de mesurer la vitesse du vent.
<p align="center">
  <img src="https://img1.bgxcdn.com/thumb/large/oaupload/banggood/images/29/15/fda1c9a0-82e2-46c5-bc91-45537a304ef2.jpg" width="313px" height="340px"/></p>

* Singal de sortie  :   sortie logique de fréquence variable [0 à 250 Hz].
* Plage             :   mesure une vitesse [0 à 250 Km/h].

## Une girouette qui nous permettra de capter la direction du vent.
<p align="center">
  <img src="https://i.ebayimg.com/images/g/PoEAAOSwm4Na~Nht/s-l300.jpg" width="300px" height="300px"/></p>

* Singal de sortie  :   sortie analogique [0 à 1 Volt].
* Plage             :   mesure un angle [0 à 360 degré].

# Exploration architecturale

## Cette fonction sera divisée en 4 sous fonctions :
+ Captage direction vent (F1.1).
+ Conversion / Adaptation (F1.2).
+ Captage force vent (F1.3).
+ Conversion / Adaptation (F1.4).

Lesquelles auront en entrées "Position voilier" ainsi que "Vent" et donneront en sorties "Direction_vent" et "Force_vent".

## Capatage direction vent (F1.1) sera divisée en trois parties :

+ Un diviseur de fréquence nous permettant d'obtenir une horloge de 1 Hz pour effectuer une mesure toutes les secondes.
+ Un compteur pour récupérer la valeur allant de [0 à 250 Hz].
+ Un registre, composée d'une simple basule D, pour mémoriser la valeur et la transmettre par la suite.

## Conversion / Adaptation (F1.2) sera divisée en  parties :

+ .
+ .
+ .

## Capatage force vent (F1.3) sera divisée en  parties :

+ .
+ .
+ .

## Conversion / Adaptation (F1.4) sera divisée en  parties :

+ .
+ .
+ .