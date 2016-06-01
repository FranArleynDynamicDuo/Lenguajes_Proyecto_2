# Lenguajes_Proyecto_2

Universidad Simón Bolívar
Departamento de Computación
Laboratorio de Lenguajes de Programación
Prof. Wilmer Pereira
Abril-Junio/2016


Proyecto Prolog (20%)


1. Objetivo

	La intención es ejercitar habilidades en Prolog para distintas representaciones de árboles usando estructuras y listas. Como estructura cada árbol son nodos y aristas etiquetados con enteros positivos que cumplen ciertas propiedades. Como listas los árboles son a su vez listas del número de hijos. Ambas representaciones serán relacionadas entre ellas.


2. Árboles como estructuras

	Bajo esta representaciones partiremos de un conjunto de nodos V y un conjunto de aristas E donde etiquetas(V) son números enteros positivos sobre los nodos y etiquetas(E) son números enteros positivos de las aristas

	Un árbol compuesto de un sólo nodo con etiqueta r sera representado como:

		nodo(r,[])

	y un árbol cuya raíz tiene etiqueta r y con n sub-árboles, será representado mediante la estructura

	nodo(r,[arista(e1,A1), arista(e2,A2), ... arista(en,An)])

	donde arista(ei,Ai) representa a la arista que conecta al i-ésimo sub-árbol con etiqueta ei

	Dado un árbol A=(V,E) con |V|=N≥1 (y por lo tanto |E|=N-1) diremos que A está bien etiquetado si:

		Para todo e perteneciente a E, si a y b son las etiquetas de sus extremos, la etiqueta de la arista es
		e=|a-b|
		etiquetas(V)={1, ... N}
		etiquetas(E)={1, ... N-1}

	Ejemplo de un árbol bien etiquetado

		nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))])

	Ud. deberá implementar el predicado

		bienEtiquetado(+Arbol)

	de forma tal que, dado Arbol, se satisfaga si está bien etiquetado


3. Árboles como listas

	En este caso consideraremos árboles no ordenados, los cuales denominaremos r-arios si ninguno de sus nodos tiene más de r hijos. Consideraremos que el nivel i de un árbol contiene los nodos de este a profundidad i 

	La forma de un árbol que llamaremos esqueleto, estará representado en Prolog mediante un término, para un árbol de altura n, como esq([l0, ... ln-1]). Cada li es una lista de enteros que representa el nivel i del árbol. Estas listas tienen las siguientes características:

	l0=[u] con u el número de hijos de la raíz 
	Si li=[a0, ... an] entonces 
		- ai es el número de hijos del nodo que representa
		- Si todo ai =0 entonces ln+1=[]; en caso contrario
			li+1=[b00, ... b0a0, b10, ... b1a1, ... bn0, ... bnan]
	   donde cada secuencia bi0, ... biai representa a los hijos de ai y es SIEMPRE no  
	   creciente

	El ejemplo anterior se representaría como:

		esq([[3],[0,0,0]])

	Ud. deberá implementar los predicados:
	
		esqueleto(+N,+R,-esqueleto)

	Debe satisfacerse o re-satisfacerse con todos los esqueletos de árboles R-arios con N>0 nodos en el esqueleto etiquetamiento(+Esqueleto,-Arbol)

	Debe satisfacerse si Arbol es un buen etiquetamiento de Esqueleto esqEtiquetables(+R,+N)

	Debe satisfacerse si todos los esqueletos de árboles R-arios con N nodos son bien etiquetables describirEtiquetamiento(+Arbol)

	Debe mostrar en pantalla una descripción de Arbol y de su etiquetamiento, de una manera sencilla y fácil de entender, que permita apreciar si el árbol está bien etiquetado. Una posibilidad es listar las aristas y los nodos extremos con sus etiquetas en DFS o BFS. Quizás para identificar cada nodo, además de su etiqueta,  se puede enumerar la raíz como 0, los hijos de esta como 0.0, 0.1, ... los hijos del nodo 0.0 como 0.0.0, 0.0.1 y así sucesivamente


4. Condiciones de entrega

	Los grupos son de máximo dos personas

	Deben utilizar WinProlog pues será evaluado sobre esta plataforma 

	El código debe estar documentado y será entregado por email a wpereira@usb.ve, indicando nombre y apellido de los integrantes.
