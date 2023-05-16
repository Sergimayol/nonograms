cls:-write('\e[2J'), gotoXY(0,0).
gotoXY(X,Y):-write('\e['),write(X),write(";"),write(Y),write("H").

colorsValids([negre,vermell,verd,groc,blau,lila,cel]).

color(negre):-write("\e[1;90m").
color(vermell):-write("\e[1;91m").
color(verd):-write("\e[1;92m").
color(groc):-write("\e[1;93m").
color(blau):-write("\e[1;94m").
color(lila):-write("\e[1;95m").
color(cel):-write("\e[1;96m").
color(blanc):-write("\e[1;97m").

showList([]).
showList([X|L]):-
    write(X),
    nl,
    showList(L).

treuPistas([],[]).
treuPistas([X|L1], [Y|L2]):-
    extreuPista(X,Y),
    treuPistas(L1,L2).

extreuPista([], []).
% Caso [seguits, color, 1]
extreuPista([X|L1], [seguits, X, 1], L2):-
    vegades(X, [X|L1], 1),
    !,
    extreuPista(L1, L2).
% Caso [seguits, color, N]
extreuPista([X|L1], [seguits, X, N], L2):-
    vegades(X, [X|L1], N),
    seguits(N, X, [X|L1]),
    !,
    borrar(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L2).
% Caso [no_seguits, color, N]
extreuPista([X|L1], [separats, X, N], L2):-
    vegades(X, [X|L1], N),
    !,
    borrar(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L1).

vegades(_, [], 0).
vegades(X, [X|L], N):-
    vegades(X, L, N1),
    N is N1 + 1.
vegades(X, [Y|L], N):-
    X \= Y,
    vegades(X, L, N).

seguits(0, _, _).
seguits(N, X, [X|L]):-
    N1 is N - 1,
    seguits(N1, X, L).

borrar(_, [], []).
borrar(X, [X|L1], L2):-
    borrar(X, L1, L2).
borrar(X, [Y|L1], [Y|L2]):-
    X \= Y,
    borrar(X, L1, L2).

showRow([],_).
showRow([X|L], Inc):-
    color(X),
    write("X"),
    shwoNspaces(Inc),
    showRow(L, Inc).

shwoNspaces(0).
shwoNspaces(N):-
    write(" "),
    N1 is N - 1,
    shwoNspaces(N1).

showNonogram([], _, _, _, _).
showNonogram([X|L], Fil, Col, IncF, IncC):-
    gotoXY(Fil, Col),
    showRow(X, IncF),
    Col1 is Col + IncC,
    showNonogram(L, Fil, Col1, IncF, IncC).

getRandomColor([X], X).
getRandomColor([_|L], C):-
    random(N),
    N1 is round(N) * 100,
    N1 < 50,
    getRandomColor(L, C).
getRandomColor([X|_], X).

generateRandomRow(_, 0, []).
generateRandomRow(Cs, Col, L):-
    getRandomColor(Cs, C),
    append([C], L1, L),
    Col1 is Col - 1,
    generateRandomRow(Cs, Col1, L1).

% Función para escribir por pantalla las filas de un nonograma
% Parametros:
%   - Lista de filas del nonograma (lista de listas)
escriuNonograma(Nono):-
    showList(Nono). 

% Función para pintar, graficament, en la pantalla un nonograma.
% Parametros:
%   - Lista de filas del nonograma (lista de listas)
%   - Número de filas del nonograma
%   - Número de columnas del nonograma
%   - Separación entre filas
%   - Separación entre columnas
mostraNonograma([X|L], Fil, Col, IncF, IncC):-
    cls,
    showNonogram([X|L], Fil, Col, IncF, IncC).

% Función para construir un nonograma aleatorio a partir de una lista de colores, 
% un número de filas y un número de columnas.
% Parametros:
%   - Lista de colores validos
%   - Número de filas del nonograma
%   - Número de columnas del nonograma
%   - Nonograma generado
ferNonograma(_, 0, _, []).
ferNonograma(Colors, Fil, Col, Nono):-
    generateRandomRow(Colors, Col, Row),
    append([Row], Nono1, Nono),
    Fil1 is Fil - 1,
    ferNonograma(Colors, Fil1, Col, Nono1).

% Función para extrar las pistas dado un nonograma
% Parametros:
%   - Lista de filas del nonograma (lista de listas)
%   - Descripción de las pistas
descriuNonograma(Nono, Desc):-
    % Hacer pista para las filas
    % Transponer el nonograma
    % Hacer pista para las columnas
    write("TODO").

mostraPistesHoritzontals(DescHo, F, C, FInc, CInc):-
    write("TODO").

mostraPistesVerticals(DescVer, F, C, FInc, CInc):-
    write("TODO").

resolNonograma(Desc, Sol):-
    write("TODO").
