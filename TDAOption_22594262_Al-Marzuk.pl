%RF2: TDA Option (Constructor)
%Descripción: Predicado que crea una opción, que es una lista con los elementos del dominio
%Dominio: Code (Integer) X Message (String) X ChatbotCodeLink (Integer) X InitialFlowCodeLink (Integer) X Keywords (List)
%
%

option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords,
       [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]) :-
    integer(Code), string(Message), integer(ChatbotCodeLink), integer(InitialFlowCodeLink),
    is_list(Keywords).
