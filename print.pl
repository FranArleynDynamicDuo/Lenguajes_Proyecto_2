% describirEtiquetamiento
%-------------------------------------------------------------------
etiquetas(arista(Etiqueta,_),Retorno) :- Retorno is Etiqueta.
obtenerNodoDestino(arista(_,Nodo),Retorno):- Retorno = Nodo.
etiquetas(nodo(Etiqueta,_),Retorno) :- Retorno is Etiqueta.
%-------------------------------------------------------------------

% describirEtiquetamiento
describirAux(nodo(Et,[H|T]), AristasUsadas,AristasUsadasNueva, NodosUsados,NodosUsadosNuevos) :-
	obtenerNodoDestino(H,NodoDestino),
	etiquetas(H,EtiquetaArista),
	etiquetas(NodoDestino,EtiquetaDest),
	write('nodo '), write(Et), write(' - '), 
	write('arista '), write(EtiquetaArista), write(' -> '),
	write('nodo '), write(EtiquetaDest), 		
	nl,
	% Analizamos el arbol que esta al final de la arista seleccionada
	describirAux(NodoDestino,[EtiquetaArista|AristasUsadas],AristasUsadasNueva2,[EtiquetaDest|NodosUsados],NodosUsadosNuevos2),
	%Acum1 is Acum + 1,
	% Analizamos la siguiente arista
	describirAux(nodo(Et,T),AristasUsadasNueva2,AristasUsadasNueva, NodosUsadosNuevos2,NodosUsadosNuevos).
	

% Caso 1: Arbol con mas de un nodo
describirAux(nodo(_,[]), AristasUsadas,AristasUsadasNueva, NodosUsados,NodosUsadosNuevos) :-
	AristasUsadasNueva = AristasUsadas,
	NodosUsadosNuevos = NodosUsados.

% DESCRIBIR ETIQUETAMIENTO
describirEtiquetamiento(nodo(Et,[H|T])) :-
	nl,
	write('El Procedimiento recorre el arbol en DFS: '),
	nl,
	describirAux(nodo(Et,[H|T]),[],_, [Et|[]] ,_).

