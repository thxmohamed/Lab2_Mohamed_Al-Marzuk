:- consult('tdaflow_22594262_Al-Marzuk.pl').

/*
 ##########################################
 #Funciones de Pertenencia del TDA Chatbot#
 ##########################################
*/


/*
 Nombre: chatbotGetFlows/2
 Dominio: Chatbot, Flows
 Descripción: Entrega los flujos del Chatbot
 */

chatbotGetFlows([_, _, _, _, Flows], Flows).

/*
 Nombre: chatbotGetName/2
 Dominio: Chatbot, Name
 Descripción: Entrega el nombre del chatbot
 */


chatbotGetName([_, ChatbotName, _, _, _], ChatbotName).

/*
 Nombre: chatbotGetID/2
 Dominio: Chatbot, ID
 Descripción: Entrega el ID del chatbot
 */


chatbotGetID([ID, _, _, _, _], ID).

/*
 Nombre: chatbotGetMsg/2
 Dominio: Chatbot, Msg
 Descripción: Entrega el mensaje de bienvenida del chatbot
 */


chatbotGetMsg([_ , _, Msg, _, _], Msg).

/*
 Nombre: chatbotGetIDFlow/2
 Dominio: Chatbot, IDFlow
 Descripción: Entrega el ID del flujo inicial del chatbot
 */

chatbotGetIDFlow([_, _, _, FlowID, _], FlowID).

/*
 Nombre: chatbotUpdateFlowID/3
 Dominio: Chatbot, IDFlow X NewChatbot
 Descripción: modifica el ID del flujo actual del chatbot
 */

chatbotUpdateFlowID([ID, ChatbotName, Msg, _, Flows], NewID, [ID, ChatbotName, Msg, NewID, Flows]).

/*
 Nombre: chatbotFlowSearch/2
 Dominio: Chatbot, IdFlow, OptionList
 Descripción: Regla recursiva que lo que hace es extraer todos los
 nombres de las opciones contenidas en un flujo, en base a su ID.
 Recursion Usada: de Cola
 Metas primarias: Encontrar una lista con todas las opciones de un flujo
 en base a su ID
 Metas secundarias: no aplica
*/

% Condicion de parada, no hay más flows, retorna una lista vacía
chatbotFlowSearch(Chatbot, _, []) :-
    chatbotGetFlows(Chatbot, Flows),
    isNull(Flows).

% Segunda condición de parada, el primer Flow coincide en ID con el ID
% que le paso, en ese caso me devuelve las opciones
chatbotFlowSearch(Chatbot, IdFlow, OptionList) :-
    chatbotGetFlows(Chatbot, [Flow1 | _]),
    flowGetID(Flow1, ID),
    ID = IdFlow,
    flowOptionSearch(Flow1, OptionList).

% Caso recursivo, busca en el resto de flujos
chatbotFlowSearch(Chatbot, IdFlow, OptionList) :-
    chatbotGetFlows(Chatbot, [_ | RestoFlows]),
    chatbotFlowSearch([_, _, _, _, RestoFlows], IdFlow, OptionList).

/*
 Nombre: chatbotFindFlow/3
 Dominio: Chatbot, IdFlow, Flow
 Descripción: Regla recursiva que lo que hace es buscar un flow dentro
 de un chatbot en base a su ID.
 Recursion Usada: de Cola
 Metas primarias: Encontrar un flow en base a su ID
 Metas secundarias: no aplica
*/

% Condicion de parada, no hay más flows en el chatbot, retorna una lista
% vacía

chatbotFindFlow([_, _, _, _, []], _, []).

% segunda condicion de parada, el primer flow coincide en ID con el ID
% que le paso, retorna ese flow

chatbotFindFlow([_, _, _, _, [Flow1|_]], FlowID, Flow):-
    flowGetID(Flow1, ID),
    ID == FlowID,
    Flow = Flow1.

%Caso recursivo, busca en el resto de flows

chatbotFindFlow([_, _, _, _, [_|RestoFlows]], FlowID, Flow) :-
    chatbotFindFlow([_, _, _, _, RestoFlows], FlowID, Flow).

