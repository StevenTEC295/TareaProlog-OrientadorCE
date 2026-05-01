
% ARCHIVO: BNF.pl (Parser Interpretativo - Prioridad Negativa)

%alanizar_oracion se encargade de consumir la lista de palabras y devolver una intencion (afirmativo o negativo) segun el patron que encuentre, con prioridad a lo negativo. Si encuentra un "no" o verbo negativo, se asume negativo, incluso si hay palabras positivas despues. Si no encuentra nada negativo, se asume afirmativo si encuentra palabras positivas o afirmaciones. Si no encuentra nada, falla y se vuelve a preguntar.
analizar_oracion(ListaPalabras, Intencion) :-
    %once se asegura de que solo se tome la primera coincidencia encontrada, evitando ambigüedades y garantizando una respuesta clara.

    once(phrase(oracion(Intencion), ListaPalabras)).
% La estructura de la oración se define con relleno opcional antes y después del núcleo, que es donde se encuentra la intencion principal. El relleno permite que el parser ignore palabras irrelevantes o de transición, enfocándose en las partes clave de la respuesta.
oracion(Intencion) --> relleno, nucleo(Intencion), relleno.

% El relleno es una secuencia de palabras que no afectan la intención principal de la respuesta. Puede ser cualquier palabra o conjunto de palabras, incluyendo ninguna (lista vacía). Esto permite que el parser sea flexible y pueda manejar respuestas con diferentes estructuras y niveles de detalle, sin perder la capacidad de identificar la intención principal.
relleno --> [].
relleno --> [_], relleno.

%  extraer la intecnion de la respuesta, con prioridad a lo negativo (si hay un "no" o verbo negativo, se asume negativo)
nucleo(negativo) --> frase_indirecta_negativa.
nucleo(negativo) --> pivot, relleno. 
nucleo(negativo) --> verbo_negativo.
nucleo(negativo) --> negacion, relleno, verbo_positivo. 
nucleo(negativo) --> negacion, relleno, frase_indirecta_positiva. 
nucleo(negativo) --> negacion.

nucleo(afirmativo) --> frase_indirecta_positiva.
nucleo(afirmativo) --> verbo_positivo.
nucleo(afirmativo) --> afirmacion.

%  diccioario de palabras para el parser (con prioridad a lo negativo)

% respuestas indirectas (con adjetivos o frases comunes que denotan gusto o disgusto)
frase_indirecta_positiva --> [soy, de, esas, cosas] | [soy, asi] | [me, defiendo]| [puede, ser].
frase_indirecta_positiva --> [interesante] | [suena, bien] | [me, llama, la, atencion] | [chiva].

frase_indirecta_negativa --> [son, aburridas] | [es, aburrido] | [se, me, hace, dificil] | [son, dificiles].

% el pivot se encarga de marcar el inicio de una respuesta que puede ser afirmativa o negativa, dependiendo del verbo o negacion que le siga.
pivot --> [soy, mas, de] | [prefiero] | [me, inclino, por].

%afirmaciones y negaciones explícitas
afirmacion --> [si] | [claro] | [obvio] | [exacto] | [correcto].
negacion --> [no] | [nunca] | [jamas] | [tampoco].

% Verbos Positivos (Con infinitivos)
verbo_positivo --> [amo] | [amas] | [amamos] | [aman] | [amaba] | [amar].
verbo_positivo --> [gusta] | [gustan] | [gustaba] | [gustaban] | [gustaria] | [gustar].
verbo_positivo --> [encanta] | [encantan] | [encantaba] | [encantaria] | [encantar].
verbo_positivo --> [disfruto] | [disfrutamos] | [apasiona] | [apasionan] | [disfrutar] | [apasionar].
verbo_positivo --> [interesa] | [interesan] | [adoro] | [interesar] | [adorar].

% Verbos Negativos (Con infinitivos)
verbo_negativo --> [odio] | [odiamos] | [odian] | [odiaba] | [odiar].
verbo_negativo --> [detesto] | [detestamos] | [detestan] | [detestar].
verbo_negativo --> [desagrada] | [desagradan] | [aburre] | [aburren] | [desagradar] | [aburrir].
verbo_negativo --> [tolero] | [soporto] | [aguanto] | [tolerar] | [soportar] | [aguantar].