:- consult('tdaflow_22594262_Al-Marzuk.pl').

/*
 Nombre: chatbotGetFlows/2

 Dominio: Chatbot, Flows

 Descripción: Entrega los flujos del Chatbot
 */

chatbotGetFlows([_, _, _, _, Flows], Flows).

/*
 Nombre: chatbotGetName/2

 Dominio: Chatbot, Name (String)

 Descripción: Entrega el nombre del chatbot
 */


chatbotGetName([_, ChatbotName, _, _, _], ChatbotName).

/*
 Nombre: chatbotGetID/2

 Dominio: Chatbot, ID (Integer)

 Descripción: Entrega el ID del chatbot
 */


chatbotGetID([ID, _, _, _, _], ID).

/*
 Nombre: chatbotGetMsg/2

 Dominio: Chatbot, Msg (String)

 Descripción: Entrega el mensaje de bienvenida del chatbot
 */


chatbotGetMsg([_ , _, Msg, _, _], Msg).

/*
 Nombre: chatbotGetIDFlow/2

 Dominio: Chatbot, IDFlow (Integer)

 Descripción: Entrega el ID del flujo inicial del chatbot
 */

chatbotGetIDFlow([_, _, _, FlowID, _], FlowID).

/*
 Nombre: chatbotUpdateFlowID/3

 Dominio: Chatbot, IDFlow (Integer) X NewChatbot

 Descripción: modifica el ID del flujo actual del chatbot
 */

chatbotUpdateFlowID([ID, ChatbotName, Msg, _, Flows], NewID, [ID, ChatbotName, Msg, NewID, Flows]).

/*
 Nombre: chatbotFlowSearch/3

 Dominio: Chatbot, IdFlow (Integer), OptionList

 Descripción: Regla recursiva que lo que hace es extraer todos los
 nombres de las opciones contenidas en un flujo, en base a su ID.

 Recursion Usada: de Cola

 Metas primarias: chatbotFlowSearch/3

 Metas secundarias: chatbotGetFlows/2, isNull/1, flowGetID/2,
 flowOptionSearch/2
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

 Dominio: Chatbot, IdFlow (Integer), Flow

 Descripción: Regla recursiva que lo que hace es buscar un flow dentro
 de un chatbot en base a su ID.

 Recursion Usada: de Cola

 Metas primarias: chatbotFindFlow(3

 Metas secundarias: flowGetID/2
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

