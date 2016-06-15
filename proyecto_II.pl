% Potencia(+X,+Y,-Z)
% Funcion que calcula la potencia Y de X
%	X: Numero Base
%	Y: Exponente
%	Z: Resultado
potencia(0,0,'ERROR') :- !.
potencia(X,0,1) :- X =\= 0.
potencia(X,Y,Z) :- A is Y -1, potencia(X,A,B), Z is B*X.

% numeroAleatorioSeguro(+NumeroNodosTotal,+NumeroNodosPorNivel,-Resultado)
% Obtiene un numero al azar valido para el esqueleto
%	NumeroNodosTotal: Numero total de nodos del arbol
%	NumeroNodosPorNivel: Numero de nodos por nivel
%	Resultado: Resultado

% Caso 1: Quedan menos nodos disponibles que el maximo por nivel
numeroAleatorioSeguro(NumeroNodosTotal,NumeroNodosPorNivel,Resultado) :-
	NumeroNodosTotal < NumeroNodosPorNivel,
	random_between(0, NumeroNodosTotal, Resultado).
% Caso 2: Quedan menos nodos disponibles que el maximo por nivel	
numeroAleatorioSeguro(NumeroNodosTotal,NumeroNodosPorNivel,Resultado) :-
	NumeroNodosTotal >= NumeroNodosPorNivel,
	random_between(0, NumeroNodosPorNivel, Resultado).

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

% Caso 1: Final Del Esqueleto
numeroNodosEsqueleto(esq([H|[]]),SumaAcumulada,SumaFinal) :-
	sum_list(H,SumaTemp),
	SumaFinal is SumaAcumulada + SumaTemp.
% Caso 2: Caso Principal
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

%	esqueleto
%	Crea un esqueleto de un arbol	
% 	+N : Numero de Niveles Del Arbol
%	+R : Numero de hijos Por N
%	-esqueleto: Arbol Resultante

% Caso Base: Arbol con 1 Nodo
esqueleto(1,_,[[0]]).

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
	% Obtenemos un numero al azar de hijos
	numeroAleatorioSeguro(N,R,Numero),
	% Reducimos el numero de nodos restantes
	N1 is N - Numero - 1,
	% Agregamos el nodo
	NivelTemp = [Numero|[]],
	% Agregamos un nodo al nivel
	ListaNueva2 = [NivelTemp|[]],
	% Contruimos el esqueleto utilizando una funcion auxiliar
	esqueleto_Aux(N1,R,ListaNueva2 , ListaSalida),
	% Revertimos la lista
	reverse(ListaSalida,ListaRevertida),
	% Devolvemos el esqueleto final
	Esqueleto = esq(ListaRevertida).

% esqueleto_Aux(+N,+R,+ListaEntrada ,-ListaSalida)
% Funcion auxiliar para la recursion de esqueleto
%	N: Numero de Nodos restantes
%	R0: Maximo de hijos por nivel
%	R: Numero de Hijos restantes por crear
%	ListaEntrada: Lista Original
%	ListaSalida: Lista Final

% Caso 1: Primer Nivel
esqueleto_Aux(0,_,_,[H|T] , ListaSalida) :-
	%
	sum_list(H,NumeroDeNodosEnNivel),
	% Construimos la lista referente al nivel N
	construirNivel(_,NumeroDeNodosEnNivel,0,_, [],_),
	% Retorno la lista
	ListaSalida = [H|T].

% Caso 2: Niveles posteriores
esqueleto_Aux(_,_,[[]|T] , ListaSalida) :-
	% Retorno la lista
	ListaSalida = T.

% Caso 2: Niveles posteriores
esqueleto_Aux(N,R0,[H|T] , ListaSalida) :-
	%
	sum_list(H,NumeroDeNodosEnNivel),
	% Construimos la lista referente al nivel N
	construirNivel(R0,NumeroDeNodosEnNivel,N,NodosRestanteNuevo, [],ListaSalida2),
	% Llamamos a la funcion de nuevo para agregar otro nivel
	esqueleto_Aux(NodosRestanteNuevo,R0,[ListaSalida2|[H|T]] , ListaSalida3),
	% Retornamos la lista final
	ListaSalida = ListaSalida3.

% construirNivel(R0,Restante, ListaEntrada,ListaRetorno).
% Construye un nivel del esqueleto con el maximo de elementos
%	R0: Maximo numero de nodos por nivel
%	Restante: Nodos restantes por agregar
%	N: Nodos restantes
%	ListaEntrada: Lista de entrada para la recursion
%	ListaRetorno: Lista de salida

% Caso Base: No quedan nodos por agregar
construirNivel(_,0,NodosRestantes,NodosRestantesNuevo, ListaEntrada,ListaRetorno) :-
	%
	NodosRestantesNuevo = NodosRestantes,
	% Retornamos el resultado
	ListaRetorno = ListaEntrada.
	
% Caso 1: Estamos agregando el primer Nodo
construirNivel(R0,Restante,0,_, [],ListaRetorno) :-
	% Restamos un nodo al contador
	RestanteTemp is Restante - 1,
	% Construimos el nuevo nivel
	construirNivel(R0, RestanteTemp,0,_, [0|[]], ListaRetorno2),
	% Retornamos la lista
	ListaRetorno = ListaRetorno2.	
	
% Caso 2: Estamos agregando otros nodos ademas del primero
construirNivel(R0,Restante,0,NodosRestantesNuevo, ListaEntrada,ListaRetorno) :-
	%
	RestanteTemp is Restante - 1,
	% Construimos el nuevo nivel
	construirNivel(R0, RestanteTemp,0,NodosRestantesNuevoTemp, [0|ListaEntrada], ListaRetorno2),
	% 
	NodosRestantesNuevo = NodosRestantesNuevoTemp,
	% Retornamos la lista
	ListaRetorno = ListaRetorno2.

% Caso 1: Estamos agregando el primer Nodo
construirNivel(R0,Restante,NodosRestantes,NodosRestantesNuevo, [],ListaRetorno) :-
	%
	numeroAleatorioSeguro(NodosRestantes,R0,Numero),
	% 
	NodosRestantesTemp is NodosRestantes - Numero,
	%
	RestanteTemp is Restante - 1,
	% Construimos el nuevo nivel
	construirNivel(R0, RestanteTemp,NodosRestantesTemp,NodosRestantesNuevoTemp, [Numero|[]], ListaRetorno2),
	%
	NodosRestantesNuevo = NodosRestantesNuevoTemp,
	% Retornamos la lista
	ListaRetorno = ListaRetorno2.

% Caso 2: Estamos agregando otros nodos ademas del primero
construirNivel(R0,Restante,NodosRestantes,NodosRestantesNuevo, ListaEntrada,ListaRetorno) :-
	% 
	numeroAleatorioSeguro(NodosRestantes,R0,Numero),
	%
	NodosRestantesTemp is NodosRestantes - Numero,
	%
	RestanteTemp is Restante - 1,
	% Construimos el nuevo nivel
	construirNivel(R0, RestanteTemp,NodosRestantesTemp,NodosRestantesNuevoTemp, [Numero|ListaEntrada], ListaRetorno2),
	% 
	NodosRestantesNuevo = NodosRestantesNuevoTemp,
	% Retornamos la lista
	ListaRetorno = ListaRetorno2.

% etiquetamiento(+Esqueleto,-Arbol)

% Algoritmo: las aristas se colocan en BFS, las etiquetas de los nodos se calculan

etiquetamiento(esq([[H1|T1]|T]),ArbolResultante) :-
	% Obtenemos el numero de hijos del nodo original
	NumeroDeHijos is H1,
	ListaEntrada = T,
	numeroNodosEsqueleto(esq([[H1|T1]|T]),0,NumeroNodos),
	AristaActual is NumeroNodos - 1,
	etiquetamientoAux(nodo(NumeroNodos,[]),NumeroDeHijos,AristaActual,_,ArbolResultante).
	
etiquetamientoAux(nodo(Et,[0|_]),_, EtiquetaNodoPadre,AristaActual,_,ArbolResultante) :-
	Etiqueta is EtiquetaNodoPadre - AristaActual,
	ArbolResultante = nodo(Etiqueta,[]).
	
etiquetamientoAux(nodo(Et,[_|[]]),_,_,ArbolActual,ArbolResultante) :-
	ArbolResultante = ArbolActual.
	
etiquetamientoAux(nodo(Et,[H|T]),NumeroDeHijos,AristaActual,ArbolActual,ArbolResultante) :-
	H > 0,
	% Recorro hacia abajo
	etiquetamientoAux([H|T],NumeroDeHijos,AristaActual,ArbolActual,ArbolResultante),
	% Recorro hacia los lados
	etiquetamientoAux(T,NumeroDeHijos,AristaActual,ArbolActual,ArbolResultante).
	
	 
 
	
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