% ARCHIVO: BNF.pl (Parser Interpretativo - Cumplimiento Estricto)

analizar_oracion(ListaPalabras, Intencion) :-
    % once/1 asegura obtener solo el primer resultado válido, evitando ambigüedades.
    once(phrase(oracion(Intencion), ListaPalabras)).


% reglas de la oraciones 

oracion(afirmativo) --> sintagma_nominal, sintagma_verbal(afirmativo). % Sujeto seguido de acción positiva.
oracion(afirmativo) --> afirmacion, sintagma_nominal, sintagma_verbal(afirmativo). % Ej: "sí, el juego me gusta"
oracion(afirmativo) --> sintagma_verbal(afirmativo). % Sujeto tácito (ej: "me gusta")
oracion(afirmativo) --> afirmacion, sintagma_verbal(afirmativo). 

oracion(negativo) --> sintagma_nominal, sintagma_verbal(negativo). % Sujeto seguido de acción negativa.
oracion(negativo) --> negacion, sintagma_nominal, sintagma_verbal(_). % La negación inicial invierte el sentido del verbo.
oracion(negativo) --> afirmacion, sintagma_nominal, sintagma_verbal(negativo).
oracion(negativo) --> sintagma_verbal(negativo).
oracion(negativo) --> negacion, sintagma_verbal(_).

% sintagmas


sintagma_nominal --> pronombre. % Un sujeto puede ser solo un pronombre (ej: "yo").
sintagma_nominal --> pronombre_objeto.
sintagma_nominal --> determinante, sustantivo.
sintagma_nominal --> determinante, sustantivo, adjetivo.

sintagma_verbal(afirmativo) --> verbo_positivo. % Acción directa (ej: "prefiero").
sintagma_verbal(afirmativo) --> verbo_positivo, complemento.
sintagma_verbal(afirmativo) --> pronombre_objeto, verbo_positivo. % (ej: "me defiendo")
sintagma_verbal(afirmativo) --> pronombre_objeto, verbo_positivo, complemento. % (ej: "me llama la atencion")
sintagma_verbal(afirmativo) --> pronombre_objeto, verbo_positivo, preposicion. % (ej: "me inclino por")
sintagma_verbal(afirmativo) --> verbo_modal, verbo_infinitivo. % (ej: "puede ser")
sintagma_verbal(afirmativo) --> verbo_positivo, adverbio, preposicion. % (ej: "soy mas de")

sintagma_verbal(negativo) --> verbo_negativo.
sintagma_verbal(negativo) --> verbo_negativo, complemento.
sintagma_verbal(negativo) --> pronombre_objeto, verbo_negativo.
sintagma_verbal(negativo) --> pronombre_objeto, pronombre_objeto, verbo_neutro, adjetivo_negativo. % (ej: "se me hace dificil")



complemento --> determinante, sustantivo.
complemento --> adjetivo.
complemento --> adverbio.
complemento --> pronombre.
complemento --> preposicion, determinante, sustantivo.
complemento --> preposicion, pronombre.



afirmacion --> [si] | [claro] | [obvio] | [exacto] | [correcto].
negacion --> [no] | [nunca] | [jamas] | [tampoco].

determinante --> [el] | [la] | [los] | [las] | [un] | [una] | [uno]| [unos]| [unas]| [esas].
sustantivo --> [cosas] | [juego] | [moto] | [anime] | [proyecto] | [idea] | [atencion] | [aire]| [libro] | [libros] | [felicidad]
|[materia]| [numeros]| [calculo]| [ecuaciones]| [geometria]|[problemas]|[resolucion]| [software]|[programacion]| [estrategia]| [comunicacion]| [interaccion] | [empatia]|
 [grupo]| [conversacion]| [dialogo]| [lectura] | [literatura]| [texto]| [expresion]| [compromiso]| [paisaje]| [cesped]| [tierra]| 
 [audiencia]| [voz]| [discurso]| [presentacion]| [presentaciones]| [argumento]| [argumentos]| [personas].

pronombre --> [yo] | [nosotros] |[nosotras]| [el] | [ella] | [ellos] | [ellas] | [mi].
pronombre_objeto --> [me] | [te] | [se] | [nos] | [lo] | [la] |[le]| [los] | [las].

preposicion --> [de] | [por] | [en] | [a] | [con] | [para].
adverbio --> [asi] | [bien] | [mas].

adjetivo --> [interesante] | [chiva] | [genial]| [feliz]| [entretenido]| [ameno]| [increible].
adjetivo_negativo --> [aburrido] | [dificil] | [aburridas] | [dificiles]| [complicado]| [complicados].

verbo_positivo --> [amo] | [amas] | [amamos] | [aman] | [amaba].
verbo_positivo --> [gusta] | [gustan] | [gustaba] | [gustaban] | [gustaria].
verbo_positivo --> [agrada] | [agradan] | [agradaba] | [agradaban] | [agradaria].
verbo_positivo --> [encanta] | [encantan] | [encantaba] | [encantaria].
verbo_positivo --> [disfruto] | [disfrutamos] | [apasiona] | [apasionan].
verbo_positivo --> [interesa] | [interesan] | [adoro].
verbo_positivo --> [fascina] | [fascinan].
% Agregados para suplir las frases indirectas sin romper la gramática:
verbo_positivo --> [defiendo] | [suena] | [llama] | [soy] | [prefiero] | [inclino].

verbo_negativo --> [odio] | [odiamos] | [odian] | [odiaba].
verbo_negativo --> [detesto] | [detestamos] | [detestan].
verbo_negativo --> [desagrada] | [desagradan] | [aburre] | [aburren].
verbo_negativo --> [tolero] | [soporto] | [aguanto]| [tolerar] | [soportar] | [aguantar].
verbo_negativo --> [falta] | [faltar]| [evitar]| [evito]|[excluir]|[rechazo].

verbo_neutro --> [hace]| [hablo]| [leo]| [tengo].
verbo_modal --> [puede]|[pueda]| [quiera]| [quiero]| [quiere]| [debe]| [deberia]| [suelo]| [soler].
verbo_infinitivo --> [ser] | [amar] | [gustar] | [encantar] | [disfrutar] | [apasionar] |
 [interesar] | [adorar] | [odiar] | [detestar] | [desagradar] | [aburrir] | [tolerar] | [soportar] | [aguantar]|
 [hacer]| [leer]| [salir]| [caminar]| [hablar].