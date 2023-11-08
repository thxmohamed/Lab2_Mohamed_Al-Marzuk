module(TDAOption_22594262_almarzuk, [option/6]).

/*
 RF2: TDA Option (Constructor)
 Nombre: option/6
 Descripci�n: Predicado que crea una opci�n, que es una lista con los
 elementos del dominio
 Dominio: Code (Integer) X Message (String) X
 ChatbotCodeLink (Integer) X InitialFlowCodeLink (Integer) X Keywords
 (List) X Option (List)
 Metas Primarias: Construir option
 Metas Secundarias: Comprobar si los elementos de la lista cumplen
 con los elementos del dominio
*/

option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords,
       [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]) :-
    integer(Code), string(Message), integer(ChatbotCodeLink), integer(InitialFlowCodeLink),
    is_list(Keywords).

/*
 #########################################
 #Funciones de Pertenencia del TDA Option#
 #########################################
*/

/*
 Nombre: optionGetKeywords/2
 Dominio: Option, Keywords
 Descripci�n: Entrega las Keywords del Option
 */
optionGetKeywords([_, _, _, _, Keywords], Keywords).

/*
 Nombre: optionGetChatbotID/2
 Dominio: Option, ChatbotID
 Descripci�n:  Entrega la ID del chatbot asociado a la opci�n
 */

optionGetChatbotID([_, _, CbID, _, _], CbID).

/*
 Nombre: optionGetFlowID/2
 Dominio: Option, FlowID
 Descripci�n: Entrega la ID del flow asociado a la opci�n
 */

optionGetFlowID([_, _, _, FlowID, _], FlowID).

/*
 Nombre: optionGetName
 Dominio: Option, Name
 Descripci�n: Entrega el nombre asociado a la opci�n
 */

optionGetName([_, Name, _, _, _], Name).

