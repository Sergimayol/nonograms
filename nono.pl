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


% Función para mostrar una lista de listas
% Parametros:
%   - Lista de listas
showList([]).
showList([X|L]):-
    write(X),
    nl,
    showList(L).

% Función para realizar la transpuesta de una matriz
% Parametros:
%   - Matriz a transponer
%   - Matriz transpuesta
transposeMatrix([], []).
transposeMatrix([[]|L], []):- transposeMatrix(L, []).
transposeMatrix(M, [C|T]):-
    transposeColumn(M, C, M1),
    transposeMatrix(M1, T).

% Función para realizar la transpuesta de una columna
% Parametros:
%   - Matriz a transponer
%   - Columna transpuesta
%   - Matriz transpuesta
transposeColumn([], [], []).
transposeColumn([[X|L1]|M], [X|C], [L1|M1]):-
    transposeColumn(M, C, M1).

treuPistes([],[]).
treuPistes([X|L1], [Y|L2]):-
    extreuPista(X,Y),
    treuPistes(L1,L2).

extreuPista([], []).
% Caso [seguits, color, 1]
extreuPista([X|L1], [[seguits, X, 1]|L2]):-
    vegades(X, [X|L1], 1),
    !,
    extreuPista(L1, L2).
% Caso [seguits, color, N]
extreuPista([X|L1], [[seguits, X, N]|L2]):-
    vegades(X, [X|L1], N),
    seguits(N, X, [X|L1]),
    !,
    borrar(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L2).
% Caso [no_seguits, color, N]
extreuPista([X|L1], [[no_seguits, X, N]|L2]):-
    vegades(X, [X|L1], N),
    !,
    borrar(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L1).

vegades(_, [], 0).
vegades(X, [X|L], N):-
    vegades(X, L, N1),
    N is N1 + 1.
vegades(X, [_|L], N):-
    vegades(X, L, N).
     
seguits(0, _, []).
seguits(N, X, [X|L]) :-
    seguits(N1, X, L),
    N is N1 + 1.
seguits(N, X, [Y|L]) :-
    X \= Y,
    seguits(N, X, L).

borrar(_, [], []).
borrar(X, [X|L1], L2).
borrar(X, [Y|L1], [Y|L2]):-
    borrar(X, L1, L2).

% Función para mostrar una fila.
% Parametros:
%   - Fila a mostrar
%   - Incremento de espacios entre pistas
showRow([],_).
showRow([X|L], Inc):-
    color(X),
    write("X"),
    showNspaces(Inc),
    showRow(L, Inc).

% Función para mostrar graficamente N espacios
% Parametros:
%   - Numero de espacios
showNspaces(0).
showNspaces(N):-
    write(" "),
    N1 is N - 1,
    showNspaces(N1).

% Función para mostrar un nonograma dado una descripción del nonograma
% Parametros:
%   - Descripción del nonograma
%   - Fila donde se empieza a mostrar
%   - Columna donde se empieza a mostrar
%   - Incremento de espacios entre pistas
%   - Incremento de lineas entre pistas y el nonograma
showNonogram([], _, _, _, _).
showNonogram([X|L], Fil, Col, IncF, IncC):-
    gotoXY(Fil, Col),
    showRow(X, IncF),
    Col1 is Col + IncC,
    showNonogram(L, Fil, Col1, IncF, IncC).

% Función para obtener un color aleatorio de una lista de colores
% Parametros:
%   - Lista de colores
%   - Color aleatorio
getRandomColor([X], X).
getRandomColor([_|L], C):-
    random(N),
    N1 is round(N) * 100,
    N1 < 50,
    getRandomColor(L, C).
getRandomColor([X|_], X).

% Función para generar una fila aleatoria dado una lista de colores
% Parametros:
%   - Lista de colores
%   - Numero de columnas
%   - Fila generada
generateRandomRow(_, 0, []).
generateRandomRow(Cs, Col, L):-
    getRandomColor(Cs, C),
    append([C], L1, L),
    Col1 is Col - 1,
    generateRandomRow(Cs, Col1, L1).

% Función para mostrar una horizantal o verticalmente las pistas
% dado una descripción del nonograma (horizontal o vertical).
% Parametros:
%   - Descripción del nonograma (horizontal o vertical)
%   - Fila donde se empieza a mostrar
%   - Columna donde se empieza a mostrar
%   - Incremento de espacios entre pistas
%   - Incremento de lineas entre pistas y el nonograma
showHints([], _, _, _, _).
showHints([H|L], F, C, IncF, IncC):-
    gotoXY(F, C),
    showLine(H, IncF, IncC),
    C1 is C + IncC,
    showHints(L, F, C1, IncF, IncC).

% Función para mostrar una linea de pistas graficamente 
% dada una linea de la descipción del mismo
% Parametros:
%   - Linea de la descripción del nonograma
%   - Incremento de espacios entre pistas
%   - Incremento de espacios entre pistas y el nonograma
showLine([], _, _).
showLine([[H, C, N] | L], IncF, IncC):-
    color(C),
    N > 1,
    H == seguits,
    write("<"),
    write(N),
    write(">"),
    showNspaces(IncF),
    showLine(L , IncF, IncC).
showLine([[H, C, N] | L], IncF, IncC):-
    color(C),
    write(N),
    showNspaces(IncF),
    showLine(L, IncF, IncC).

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
    treuPistes(Nono, DescF),
    % Transponer el nonograma
    transposeMatrix(Nono, NonoT),
    % Hacer pista para las columnas
    treuPistes(NonoT, DescC),
    % Concatenar las pistas de las filas y las columnas
    append(DescF, DescC, Desc).

% Función para pintar las pistas dada una descripción de hortizontales
% Parametros:
%   - Descripción de las pistas
%   - Fila inicial para pintar las pistas
%   - Columna inicial para pintar las pistas
%   - Incremento de fila para pintar las pistas
%   - Incremento de columna para pintar las pistas
mostraPistesHoritzontals([DescHo, _], F, C, FInc, CInc):-
    cls,
    showHints(DescHo, F, C, FInc, CInc).

% Función para pintar las pistas dada una descripción de verticales 
% Parametros:
%   - Descripción de las pistas
%   - Fila inicial para pintar las pistas
%   - Columna inicial para pintar las pistas
%   - Incremento de fila para pintar las pistas
%   - Incremento de columna para pintar las pistas
mostraPistesVerticals([_, DescVer], F, C, FInc, CInc):-
    cls,
    showHints(DescVer, F, C, FInc, CInc).

% Función para resolver un nonograma dado su descripción
% Parametros:
%   - Descripción del nonograma
%   - Solución del nonograma
resolNonograma(Desc, Sol):-
    write("TODO").
