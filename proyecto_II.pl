% etiquetas(+nodo,-Retorno)
% Obtiene la etiqueta de un nodo
% 	+nodo: Nodo del cual se extraera la etiqueta
%	-Retorno: Etiqueta extraida
etiquetas(nodo(Etiqueta,_),Retorno) :- Retorno is Etiqueta.

% etiquetas(+arista,-Retorno)
% Obtiene la etiqueta de un nodo
% 	+arista: Arista de la cual se extraera la etiqueta
%	-Retorno: Etiqueta extraida
etiquetas(arista(Etiqueta,_),Retorno) :- Retorno is Etiqueta.

% obtenerNodoDestino(+arista,-Retorno)
% Obtiene el nodo al que lleva la arista
% 	+arista: Arista a examenar
%	-Retorno: Nodo extraido
obtenerNodoDestino(arista(_,Nodo),Retorno):- Retorno = Nodo.

% bienEtiquetado(+Arbol)
% Verifica si un arbol esta bien etiquetado o no.
% 	Arbol: Arbol a examenar

% Caso Base: Nodo Unitario
bienEtiquetado(nodo(_,[])).
% Caso 1: Arbol con mas de un nodo
bienEtiquetado(nodo(Et,[H|T])) :-
	% Obtenemos el nodo al que lleva la arista
	obtenerNodoDestino(H,NodoDestino),
	% Obtenemos la etiqueta de la arista seleccionada
	etiquetas(H,EtiquetaArista),
	% Obtenemos su etiqueta
	etiquetas(NodoDestino,EtiquetaDest),
	% Calculamos la diferencia entre la etiqueta del
	% nodo origen a la etiqueta del nodo destino
	Resta is abs(EtiquetaDest - Et),
	% Verificamos que se cumple la formula de buen etiquetado
	% e=|a-b|
	EtiquetaArista =:= Resta,
	% Analizamos el arbol que esta al final de
	% la arista seleccionada
	bienEtiquetado(NodoDestino),
	% Analizamos la siguiente arista
	bienEtiquetado(nodo(Et,T)).	

% Estructura de Datos
% esq([[3],[0,0,0]])

% esqueleto(+N,+R,-esqueleto)
% 	N : Numero de Niveles Del Arbol
%	R : Numero de hijos Por N
%	esqueleto: Arbol Resultante

% Debe satisfacerse o re-satisfacerse con todos los esqueletos de árboles R-arios con N>0 nodos en el esqueleto

% etiquetamiento(+Esqueleto,-Arbol)

% Debe satisfacerse si Arbol es un buen etiquetamiento de Esqueleto

% esqEtiquetables(+R,+N)

% Debe satisfacerse si todos los esqueletos de árboles R-arios con N nodos son bien etiquetables 

% describirEtiquetamiento(+Arbol)