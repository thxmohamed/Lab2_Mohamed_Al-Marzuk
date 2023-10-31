module(TDAOption_22594262_almarzuk, [option/6]).

%RF2: TDA Option (Constructor)
%Descripción: Predicado que crea una opción, que es una lista con los elementos del dominio
%Dominio: Code (Integer) X Message (String) X ChatbotCodeLink (Integer) X InitialFlowCodeLink (Integer) X Keywords (List)
%Metas Primarias: Construir option
% Metas Secundarias: Comprobar si los elementos de la lista cumplen con
% los elementos del dominio

option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords,
       [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]) :-
    integer(Code), string(Message), integer(ChatbotCodeLink), integer(InitialFlowCodeLink),
    is_list(Keywords).
