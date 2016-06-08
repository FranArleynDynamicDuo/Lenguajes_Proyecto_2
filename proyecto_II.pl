etiquetas(nodo(etiqueta,_, Retorno)) :- Retorno = etiqueta.
etiquetas(arista(etiqueta,_, Retorno)) :- Retorno = etiqueta.

% bienEtiquetado(+Arbol)
bienEtiquetado(nodo(_,[])).
