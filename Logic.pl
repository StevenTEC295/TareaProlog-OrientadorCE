:- consult('BD.pl').
:- consult('BNF.pl').

iniciar:-
    write('OrientadorCE: Hola! Se que la tarea de buscar una carrera es dificil.'),
    nl,
    write('Estamos aqui para ayudarte! Dime que te gusta.'),
    nl, nl,
    orientar([], []).

pregunta('Te gustan las matematicas?', matematicas).
pregunta('Te gusta la tecnologia?', tecnologia).
pregunta('Te interesan las personas y sus emociones?', empatia).
pregunta('Disfrutas resolver problemas complejos?', resolucion_problemas).
pregunta('Te gusta leer y escribir?', lectura).
pregunta('Te interesa el arte o el diseno?', arte).
pregunta('Prefieres trabajar solo o de forma autonoma?', trabajo_autonomo).
pregunta('Te gusta trabajar en equipo?', trabajo_en_equipo).
pregunta('Te interesa la naturaleza o los seres vivos?', ciencias_naturales).
pregunta('Te gusta hablar en publico u organizar grupos?', liderazgo).

orientar(Afinidades, Antagonias) :-
    findall(P, pregunta(_, P), TodasPreguntas),
    length(TodasPreguntas, Total),
    length(Afinidades, NA),
    length(Antagonias, NN),
    Respondidas is NA + NN,
    Respondidas >= Total,
    !,
    recomendar(Afinidades, Antagonias).

orientar(Afinidades, Antagonias) :-
    siguiente_pregunta(Afinidades, Antagonias, TextoPregunta, Rasgo),
    !,
    format('~nOrientadorCE: ~w~n> ', [TextoPregunta]),
    read_line_to_string(user_input, Respuesta),
    procesar_respuesta(Respuesta, Intencion),
    actualizar_rasgos(Intencion, Rasgo, Afinidades, Antagonias, NuevasAfinidades, NuevasAntagonias),
    orientar(NuevasAfinidades, NuevasAntagonias).

siguiente_pregunta(Afinidades, Antagonias, Texto, Rasgo) :-
    pregunta(Texto, Rasgo),
    \+ member(Rasgo, Afinidades),  
    \+ member(Rasgo, Antagonias). 

procesar_respuesta(TextoRespuesta, Intencion) :-
    % Convertimos el string a minúsculas y lo separamos en palabras
    string_lower(TextoRespuesta, TextoMin),
    split_string(TextoMin, " ", " ", Palabras),
    maplist(atom_string, ListaAtomos, Palabras),
    % Intentamos parsear con el BNF
    (   analizar_oracion(ListaAtomos, Intencion)
    ->  true
    ;   % Si el parser no entiende, pedimos que repita
        write('OrientadorCE: Me puedes repetir? No entendi.'), nl,
        write('> '),
        read_line_to_string(user_input, NuevaRespuesta),
        procesar_respuesta(NuevaRespuesta, Intencion)
    ).

actualizar_rasgos(afirmativo, Rasgo, Afinidades, Antagonias,
                  [Rasgo|Afinidades], Antagonias).

actualizar_rasgos(negativo, Rasgo, Afinidades, Antagonias,
                  Afinidades, [Rasgo|Antagonias]).


recomendar(Afinidades, Antagonias) :-
    % Calculamos puntaje para todas las profesiones
    findall(Puntaje-Profesion,
        (   profesion(Profesion),
            calcular_puntaje(Profesion, Afinidades, Antagonias, Puntaje)
        ),
        Puntajes),
    % Ordenamos de mayor a menor y tomamos la mejor
    max_member(MejorPuntaje-MejorProfesion, Puntajes),
    MejorPuntaje > 0,  % al menos una afinidad debe coincidir
    !,
    formatear_profesion(MejorProfesion, NombreFormato),
    format('~nOrientadorCE: Dadas tus preferencias te recomendaria estudiar ~w.~n', [NombreFormato]).

% Si ninguna profesión tiene puntaje positivo
recomendar(_, _) :-
    write('OrientadorCE: No pude determinar una carrera ideal con tus respuestas.'), nl,
    write('Te recomiendo hablar con un orientador profesional.'), nl.


calcular_puntaje(Profesion, Afinidades, Antagonias, Puntaje) :-
    % Contamos afinidades que coinciden
    include(rasgoCoincidir(Profesion, afinidad), Afinidades, AfinesMatch),
    length(AfinesMatch, PuntosPositivos),
    % Contamos antagonías que coinciden
    include(rasgoCoincidir(Profesion, antagonia), Antagonias, AntMatch),
    length(AntMatch, PuntosNegativos),
    Puntaje is PuntosPositivos - PuntosNegativos.


rasgoCoincidir(Profesion, afinidad, Rasgo) :-
    afinidad(Profesion, Rasgo).
rasgoCoincidir(Profesion, antagonia, Rasgo) :-
    antagonia(Profesion, Rasgo).

formatear_profesion(medicina,              'Medicina').
formatear_profesion(ingenieria_software,   'Ingenieria en Software').
formatear_profesion(derecho,               'Derecho').
formatear_profesion(psicologia,            'Psicologia').
formatear_profesion(arquitectura,          'Arquitectura').
formatear_profesion(administracion_empresas, 'Administracion de Empresas').
formatear_profesion(ensenanza,             'Ensenanza').
formatear_profesion(periodismo,            'Periodismo').
formatear_profesion(diseno_grafico,        'Diseno Grafico').
formatear_profesion(biologia,              'Biologia').
formatear_profesion(contabilidad,          'Contabilidad').
formatear_profesion(trabajo_social,        'Trabajo Social').

formatear_profesion(P, P).

