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

% obtenerLista(+Esqueleto,-Lista)
% Obtiene la lista de un esqueleto
% 	Esqueleto: Esqueleto del cual extraer la lista
%	Lista: Lista Extraida

% Caso 1: No hay esqueleto previo
obtenerLista(esq([H|T]),ListaRetorno) :-
	ListaRetorno = [H|T].
% Caso 2: No hay esqueleto previo
obtenerLista(_,[]).

% obtenerCabeza(lista,-Elemento).
obtenerCabeza([H|_],Elemento) :-
	Elemento = H.

% construirNivel(R0,Restante, ListaEntrada,ListaRetorno).
% Construye un nivel del esqueleto con el maximo de elementos
%	R0: Maximo numero de nodos por nivel
%	Restante: Nodos restantes por agregar
%	ListaEntrada: Lista de entrada para la recursion
%	ListaRetorno: Lista de salida

% Caso Base: No quedan nodos por agregar
construirNivel(_,0, ListaEntrada,ListaRetorno) :-
	% Retornamos el resultado
	ListaRetorno = ListaEntrada.

% Caso 1: Estamos agregando el primer Nodo
construirNivel(R0,Restante, [],ListaRetorno) :-
	RestanteNuevo is Restante - 1,
	construirNivel(R0, RestanteNuevo, [R0|[]], ListaRetorno2),
	ListaRetorno = ListaRetorno2.

% Caso 2: Estamos agregando otros nodos ademas del primero
construirNivel(R0,Restante, ListaEntrada,ListaRetorno) :-
	ListaTemp = [R0|ListaEntrada],
	RestanteNuevo is Restante - 1,
	construirNivel(R0,RestanteNuevo, ListaTemp ,ListaRetorno2),
	ListaRetorno = ListaRetorno2.

% Funcion auxiliar para la recursion de esqueleto	
esqueleto_Aux(1,R,ListaEntrada , ListaSalida) :-
	NodoFinal = [R|[]],
	ListaSalida = [NodoFinal|ListaEntrada].

esqueleto_Aux(N,R,ListaEntrada , ListaSalida) :-
	NodosTotales is R * N,
	construirNivel(R,NodosTotales, [],ListaSalida2),
	N1 is N - 1,
	esqueleto_Aux(N1,R,[ListaSalida2|ListaEntrada] , ListaSalida3),
	ListaSalida = ListaSalida3.
	
% 	+N : Numero de Niveles Del Arbol
%	+R : Numero de hijos Por N
%	-esqueleto: Arbol Resultante

% Caso Base: Arbol con 1 Nodo
esqueleto(1,_,_).

% Caso 2: Arbol con mas de 1 nivel, pero con el contador de hijos en 0
esqueleto(N,0,_) :-
	N > 1,
	N is N - 1.

% Caso 1: Arbol con mas de 1 Nodo
esqueleto(N,R,Esqueleto):-
	% Verificamos que N sea mayor a 0
	N > 0,
	% Verificamos que R sea mayor a 0
	R > 0,
	% Calculamos el numero total de nodos por el nivel
	TotalNodos is R * N,
	% Construimos el nivel inicial
	construirNivel(0, TotalNodos, [], NivelTemp),
	
	% Agregamos un nodo al nivel
	ListaNueva2 = [NivelTemp|[]],
	
	N1 is N - 1,
	
	esqueleto_Aux(N1,R,ListaNueva2 , ListaSalida),
	
	% Devolvemos el esqueleto final
	Esqueleto = esq(ListaSalida).

% etiquetamiento(+Esqueleto,-Arbol)

% Debe satisfacerse si Arbol es un buen etiquetamiento de Esqueleto

% esqEtiquetables(+R,+N)

% Debe satisfacerse si todos los esqueletos de árboles R-arios con N nodos son bien etiquetables 

% describirEtiquetamiento(+Arbol)