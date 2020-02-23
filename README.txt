Macarie Razvan-Cristian, 322CB

Operatiile si numerele sunt stocate intr-un arbore de functia getAST. Pentru
ca avem in radacina operatiile si in frunze avem copii parcurgem arborele
recursiv in preordine (RSD). In main doar imping pe stiva adresa radacinii 
arborelui si apelez functia de parcurgere. In functia de parcurgere verific
daca avem numar sau operatie. Daca avem operatie apelam recursiv functia de 
preordine iar daca e numar mergem si intoarcem numarul. Pentru fiecare operatie
se calculeaza subarborele stang primul si apoi subarborele drept. Valorile
returnate cand se intoarce functia din recursivitate sunt stocate pe stiva iar
dupa ce am calculat ambii subarbori, dau pop la cele 2 valori si le calculez
operatia.

Functia atoi parcurge octet cu octet un string si scade din valoarea in ascii
48 ('0') ca sa imi intoarca cifra, inmultesc valoarea precedeta cu 10 si 
inmultesc cu 10 pana cand ajung la caracterul null. Pentru numerele negative
fac exact acelasi lucru numai ca trebui sa fac complementul fata de 2 inainte sa
returnez valoarea in eax.

Ambele functii returneaza valorile in eax si rezultatul final se gaseste tot 
in eax.

Pentur impartire am folosit extensia de semn cdq si am facut edx 0 ca sa nu am
eroare. (floating point error)