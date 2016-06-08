etiquetas(nodo(etiqueta,_, Retorno)) :- Retorno = etiqueta.
etiquetas(arista(etiqueta,_, Retorno)) :- Retorno = etiqueta.

obtenerNodoDestino(arista(_,nodo,Retorno)) :- Retorno = nodo.

% bienEtiquetado(+Arbol)
bienEtiquetado(nodo(_,[])).
bienEtiquetado(nodo(et,[H|T])) :-
	% Obtenemos el nodo al que lleva la arista
	obtenerNodoDestino(H,nodoDestino),
	% Obtenemos su etiqueta
	etiquetas(nodoDestino,etiquetaDest),
	% Calculamos la diferencia entre la etiqueta del
	% nodo origen a la etiqueta del nodo destino
	resta is abs(etiquetaDest - et),
	% Verificamos que se cumple la formula de buen etiquetado
	% e=|a-b|
	et \== resta,
	% Analizamos el arbol que esta al final de
	% la arista seleccionada
	bienEtiquetado(nodoDestino),
	% Analizamos la siguiente arista
	bienEtiquetado(nodo(et,T)).