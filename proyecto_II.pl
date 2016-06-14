% Potencia(+X,+Y,-Z)
% Funcion que calcula la potencia Y de X
%	X: Numero Base
%	Y: Exponente
%	Z: Resultado
potencia(0,0,'ERROR') :- !.
potencia(X,0,1) :- X =\= 0.
potencia(X,Y,Z) :- A is Y -1, potencia(X,A,B), Z is B*X.

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

% numeroNodosEsqueleto(+Esqueleto,+SumaAcumulada,-SumaFinal)
% Obtiene los numeros de nodos en un esqueleto
% 	+Esqueleto: Esqueleto a analizar
%	+SumaAcumulada: Suma acumulada en la recursion
%	-SumaFinal: Suma Final
numeroNodosEsqueleto(esq([H|[]]),SumaAcumulada,SumaFinal) :-
	sum_list(H,SumaTemp),
	SumaFinal is SumaAcumulada + SumaTemp.

numeroNodosEsqueleto(esq([H|T]),SumaAcumulada,SumaFinal) :-
	sum_list(H,SumaTemp), 
	SumaIniciaNueva is SumaAcumulada + SumaTemp,
	numeroNodosEsqueleto(esq(T),SumaIniciaNueva,SumaFinal).
	

% Caso 1: Arbol con mas de un nodo
bienEtiquetadoAux(nodo(Et,[H|T]), AristasUsadas,AristasUsadasNueva, NodosUsados,NodosUsadosNuevos) :-
	% Obtenemos el nodo al que lleva la arista
	obtenerNodoDestino(H,NodoDestino),
	% Obtenemos la etiqueta de la arista seleccionada
	etiquetas(H,EtiquetaArista),
	% Verificamos que la etiqueta de la arista no se encuentra repetida
	not(member(EtiquetaArista, AristasUsadas)),
	% Obtenemos su etiqueta
	etiquetas(NodoDestino,EtiquetaDest),
	% Verificamos que la etiqueta del nodo destino no se encuentra repetida
	not(member(EtiquetaDest, NodosUsados)),
	% Calculamos la diferencia entre la etiqueta del
	% nodo origen a la etiqueta del nodo destino
	Resta is abs(EtiquetaDest - Et),
	% Verificamos que se cumple la formula de buen etiquetado e=|a-b|
	EtiquetaArista =:= Resta,
	% Analizamos el arbol que esta al final de la arista seleccionada
	bienEtiquetadoAux(NodoDestino,[EtiquetaArista|AristasUsadas],AristasUsadasNueva2,[EtiquetaDest|NodosUsados],NodosUsadosNuevos2),
	% Analizamos la siguiente arista
	bienEtiquetadoAux(nodo(Et,T),AristasUsadasNueva2,AristasUsadasNueva, NodosUsadosNuevos2,NodosUsadosNuevos).

% Caso 1: Arbol con mas de un nodo
bienEtiquetadoAux(nodo(_,[]), AristasUsadas,AristasUsadasNueva, NodosUsados,NodosUsadosNuevos) :-
	AristasUsadasNueva = AristasUsadas,
	NodosUsadosNuevos = NodosUsados.

	
% bienEtiquetado(+Arbol)
% Verifica si un arbol esta bien etiquetado o no.
% 	Arbol: Arbol a examenar
% Caso 1: Arbol con mas de un nodo
bienEtiquetado(nodo(Et,[H|T])) :-
	bienEtiquetadoAux(nodo(Et,[H|T]),[],_, [Et|[]] ,_).

% Estructura de Datos
% esq([[3],[0,0,0]])

% obtenerLista(+Esqueleto,-Lista)
% Obtiene la lista de un esqueleto
% 	Esqueleto: Esqueleto del cual extraer la lista
%	Lista: Lista Extraida

% Caso 1: No hay esqueleto previo
obtenerLista(esq([H|T]),ListaRetorno) :-
	% Retornamos la lista de aristas
	ListaRetorno = [H|T].
% Caso 2: No hay esqueleto previo
obtenerLista(_,[]).

% obtenerCabeza(lista,-Elemento).
obtenerCabeza([H|_],Elemento) :-
	% Retornamos el primer elemento
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
	% Restamos un nodo del restante
	RestanteNuevo is Restante - 1,
	% Construimos el nuevo nivel
	construirNivel(R0, RestanteNuevo, [R0|[]], ListaRetorno2),
	% Retornamos la lista
	ListaRetorno = ListaRetorno2.

% Caso 2: Estamos agregando otros nodos ademas del primero
construirNivel(R0,Restante, ListaEntrada,ListaRetorno) :-
	% Agregamos el elemento a la lista
	ListaTemp = [R0|ListaEntrada],
	% Restamos un nodo del restante
	RestanteNuevo is Restante - 1,
	% Construimos el nuevo nivel
	construirNivel(R0,RestanteNuevo, ListaTemp ,ListaRetorno2),
	% Retornamos la lista
	ListaRetorno = ListaRetorno2.

% esqueleto_Aux(+N,+R,+ListaEntrada ,-ListaSalida)
% Funcion auxiliar para la recursion de esqueleto
%	N: Numero de niveles restantes
%	R: Numero de hijos por nodo
%	ListaEntrada: Lista Original
%	ListaSalida: Lista Final

% Caso 1: Primer Nivel
esqueleto_Aux(1,R,ListaEntrada , ListaSalida) :-
	% Creo Nivel Tope Del Arbol
	NodoFinal = [R|[]],
	% Retorno la lista
	ListaSalida = [NodoFinal|ListaEntrada].

% Caso 2: Niveles posteriores
esqueleto_Aux(N,R,ListaEntrada , ListaSalida) :-
	% Bajamos un nivel
	N1 is N - 1,
	% Calculamos el numero total de nodos por el nivel
	potencia(R,N1,TotalNodos),
	% Construimos la lista referente al nivel N
	construirNivel(R,TotalNodos, [],ListaSalida2),
	% Llamamos a la funcion de nuevo para agregar otro nivel
	esqueleto_Aux(N1,R,[ListaSalida2|ListaEntrada] , ListaSalida3),
	% Retornamos la lista final
	ListaSalida = ListaSalida3.

%	esqueleto
%	Crea un esqueleto de un arbol	
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
	% Reducimos el nivel para el calculo del numero de nodos
	N1 is N - 1,
	% Calculamos el numero total de nodos por el nivel
	potencia(R,N1,TotalNodos),
	% Construimos el nivel inicial
	construirNivel(0, TotalNodos, [], NivelTemp),
	% Agregamos un nodo al nivel
	ListaNueva2 = [NivelTemp|[]],
	% Contruimos el esqueleto utilizando una funcion auxiliar
	esqueleto_Aux(N1,R,ListaNueva2 , ListaSalida),
	% Devolvemos el esqueleto final
	Esqueleto = esq(ListaSalida).

% etiquetamiento(+Esqueleto,-Arbol)

% Algoritmo: las aristas se colocan en BFS, las etiquetas de los nodos se calculan

etiquetamiento(esq([[H1|T1]|T]),ArbolResultante) :-
	% Obtenemos el numero de hijos del nodo original
	NumeroDeHijos is H1,
	ListaEntrada = T,
	numeroNodosEsqueleto(esq([[H1|T1]|T]),0,NumeroNodos),
	AristaActual is NumeroNodos - 1,
	etiquetamientoAux(ListaEntrada,NumeroDeHijos,AristaActual,_,ArbolResultante).
	
etiquetamientoAux([0|_],_, EtiquetaNodoPadre,AristaActual,_,ArbolResultante) :-
	Etiqueta is EtiquetaNodoPadre - AristaActual,
	ArbolResultante = nodo(Etiqueta,[]).
	
etiquetamientoAux([_|[]],_,_,ArbolActual,ArbolResultante) :-
	ArbolResultante = ArbolActual.
	
etiquetamientoAux([H|T],NumeroDeHijos,AristaActual,ArbolActual,ArbolResultante) :-
	H > 0.
	 
 
	
%etiquetamientoAuxNivel([H|T]) :-
	

% Debe satisfacerse si Arbol es un buen etiquetamiento de Esqueleto

% esqEtiquetables(+R,+N)
% Debe satisfacerse si todos los esqueletos de árboles R-arios con N nodos son bien etiquetables 
%	+N : Numero de Niveles Del Arbol
%	+R : Numero de hijos Por N

esqEtiquetables(R,N) :-
	esqueleto(N,R,Esqueleto),
	etiquetamiento(Esqueleto,Arbol),
	bienEtiquetado(Arbol).
	
	

% describirEtiquetamiento(+Arbol)