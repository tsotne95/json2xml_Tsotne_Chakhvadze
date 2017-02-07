JSON2XML

il transforme le fichier de json dans fichier de XML.

pour utiliser, il faut installer le programs: bison et flex.

pour compiller lancer:
make

pour supprimer tout les fichiers intermédiaires:
make clean

apres avoir compiller pour transformer fichier de json, lancer, comme ca:

./json2xml <example/test1.json >result.xml 

/*
	Il y a deux fichier json dans repertoire example. 
	(Les deux exampls sont copies du web)
	Ne pas oublier ecrire '<' avant votre fichier de json
*/

et pour voir les resultats, lance ce commande:

gedit result.xml&


