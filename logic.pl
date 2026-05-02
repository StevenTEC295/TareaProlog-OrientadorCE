:- consult("BD.pl").

% Oracion
oracion(Num,Gen,S0,S):- sn(Num,Gen,S0,S1), sv(Num,S1,S).
oracion(Num,Gen,S0,S):- sn(Num,Gen,S0,S1), sv(Num,Gen,S1,S).

% Sintagma Nominal (SN)
sn(Num,Gen,S0,S):-det(Num,Gen,S0,S1), nom(Num,Gen,S1,S).

%Sintagma preposicional
sprep(Num,Gen,S0,S):-prep(S0,S1), sn(Num,Gen,S1,S).

% Sintagma Verbal (SV)
sv(Num,S0,S):-verbo(Num,S0,S).
sv(Num,Gen,S0,S):-verbo(Num,S0,S1), sprep(Num, Gen,S1,S).

% Determinante
det(Num, Gen,[X|S],S):- articulo(Num, Gen, X).
% Nombre
nom(Num, Gen,[X|S],S):- sustantivos(Num, Gen, X).
% Verbo
verbo(Num, [X|S],S):- verbos(Num,X).

%Preposicion
prep([X|S],S):- preposicion(X).




