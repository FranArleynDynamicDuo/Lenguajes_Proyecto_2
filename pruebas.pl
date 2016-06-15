% Archivo que contiene casos de prueba, estos deben
% copiarse en la linea de comando de prolog

% Arbol Con 1 nodo
% bienEtiquetado(nodo(3,[])).

% Arbol Con 2 nodos y una arista
% bienEtiquetado(nodo(3,[arista(1,nodo(2,[]))])).

% nodo(7,[arista(6,nodo(1,[arista(5,nodo(6,[])), arista(4,nodo(5,[]))])), arista(3,nodo(4,[arista(2,nodo(2,[])), arista(1,nodo(3,[]))]))])

% esq([[4], [4, 4, 4, 4], [0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,])

% Ejemplo Complejo del enunciado
% bienEtiquetado(nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))])).