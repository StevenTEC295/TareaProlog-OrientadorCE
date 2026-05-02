:- consult("BD.pl").

% ===========Oracion============
oracion(Num,Gen,Per,S0,S):- sn(Num,Gen,Per,S0,S1), sv(Num,S1,S).
oracion(Num,Gen,Per,S0,S):- sn(Num,Gen,Per,S0,S1), sv(Num,Gen,Per,S1,S).

% Sintagma Nominal (SN)
sn(Num,Gen,Per,S0,S):-det(Num,Gen,Per,S0,S1), nom(Num,Gen,S1,S).
sn(Num,Gen,Per,S0,S):-pronombre(Num, Gen, Per, S0,S).

% Sintagma Verbal (SV)
sv(Num,S0,S):-verbo(Num,S0,S).
sv(Num,Gen,Per,S0,S):-verbo(Num,S0,S1), sprep(Num,Gen,Per,S1,S).

%Sintagma preposicional
sprep(Num,Gen,Per,S0,S):-prep(S0,S1), sn(Num,Gen,Per,S1,S).


% ============Determinante=========
%Articulos definidos
det(Num, Gen,Per,[X|S],S):- articulo(Num, Gen,Per, X).

%Adjetivos demostrativos
det(Num, Gen,Per,[X|S],S):- adj_dem(Num, Gen,Per, X).

%Adjetivos posesivos
det(Num, Gen,Per,[X|S],S):- adj_pos(Num, Gen,Per, X).

% ===========Nombre================
nom(Num, Gen,[X|S],S):- sustantivos(Num, Gen, X).
% Verbo
verbo(Num, [X|S],S):- verbos(Num,X).

%============Preposicion===========
prep([X|S],S):- preposicion(X).

%============Pronombre=============
pronombre(Num,Gen,Per,[X|S],S):- pronombres(Num,Gen, Per, X).




