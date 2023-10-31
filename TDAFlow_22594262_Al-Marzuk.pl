% Descripción: Predicado que filtra los elementos de una lista, borrando
% los duplicados. Este se va a utilizar para eliminar las opciones
% duplicadas de un Flow. Esto se hace comprobando si el primer elemento
% de la lista no está en la lista acumuladora, en ese caso lo
% agrega, y en caso contrario no lo agrega y avanza con el
% siguiente elemento
% Dominio: Lista a filtrar X Lista Acumuladora X Lista Final
% Metas Primarias: Eliminar duplicados
% Metas secundarias: No aplica

use_module(TDAOption_22594262_almarzuk, [option/6]).

agregarSinDuplicados([], Acc, Acc).

agregarSinDuplicados([Elemento|Resto], Acc, ListaSalida) :-
    \+ member(Elemento, Acc),
    agregarSinDuplicados(Resto, [Elemento|Acc], ListaSalida).

agregarSinDuplicados([Elemento|Resto], Acc, ListaSalida) :-
    member(Elemento, Acc),
    agregarSinDuplicados(Resto, Acc, ListaSalida).

%RF3: TDA Flow (Constructor)
% Descripción: Predicado que crea un Flow, que es una lista con los
% elementos del dominio
% Dominio: ID (Integer) X NameMsg (String) X Options (List)
% Metas Primarias: Construir Flow
% Metas Secundarias: Comprobar si los elementos de la lista
% cumplen con los elementos del dominio


flow(ID, NameMsg, Options, [ID, NameMsg, OptionsSinDuplicados]) :-
    agregarSinDuplicados(Options, [], OptionsSinDuplicados),
    integer(ID), string(NameMsg), is_list(Options).

