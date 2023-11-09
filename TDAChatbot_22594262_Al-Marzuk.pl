%module(TDAChatbot_22594262_almarzuk, agregarSinDuplicados/3).

use_module(TDAFlow_22594262_almarzuk, agregarSinDuplicados/3).

/*
  RF5: TDA Chatbot (Constructor)
  nombre: chatbot/6
  Descripci�n: Predicado que crea un Chatbot, que es una lista con los
  elementos del dominio
  Dominio: ChatbotID (Integer) X ChatbotName (String) X WelcomeMsg
  (String) X StartFlowID X Flows (List) X Chatbot (List)
  Metas Primarias: Construir Chatbot
  Metas Secundarias: Comprobar si los elementos de la
  lista cumplen con los elementos del dominio. Comprobar si los flows a
  a�adir est�n duplicados.
 */

chatbot(ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, Flows,
        [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, FlowsSinDuplicados]) :-
    agregarSinDuplicados(Flows, [], FlowsSinDuplicados),
    integer(ChatbotID), string(ChatbotName), string(WelcomeMsg), integer(StartFlowID), is_list(Flows).


/*
  RF6: TDA Chatbot (Modificador)
  nombre: chatbotAddFlow/3
  Descripci�n: Predicado que a�ade un flujo a un chatbot de
  manera recursiva
  Recursi�n usada: De cola
  Dominio: Chatbot X Flow
  Metas Primarias: A�adir flujo a un chatbot
  Metas Secundarias: Comprobar si la lista de flujos tiene elementos, o
  si el flujo a a�adir est� ya a�adido.
 */

% Caso Base: La lista de flows est� vac�a, as� que se a�ade el flow sin
% ning�n problema.

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, []], Flow, [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [Flow]]).

% Caso recursivo: La lista de flows no est� vac�a, as� que se separa en
% el primer flow y en el resto. se comprueba si el primer flow est�
% presente en ListFlows (que ser� la lista de flows final), en ese caso,
% se avanza la recursi�n con el resto de flows, y si no est� presente,
% se a�ade a ListFlows y se avanza con el resto. As� hasta llegar al
% caso base en el que ya no hay m�s flows en el chatbot, y se a�ade
% ListFlows

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [PrimerFlow|RestoDeFlows]], ListFlows, Chatbot2) :-
    \+ member(PrimerFlow, ListFlows),
    chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, RestoDeFlows], [PrimerFlow|ListFlows], Chatbot2).

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [PrimerFlow|RestoDeFlows]], ListFlows, Chatbot2) :-
    member(PrimerFlow, ListFlows),
    chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, RestoDeFlows], ListFlows, Chatbot2).


/*
 ##########################################
 #Funciones de Pertenencia del TDA Chatbot#
 ##########################################
*/


/*
 Nombre: chatbotGetFlows/2
 Dominio: Chatbot, Flows
 Descripci�n: Entrega los flujos del Chatbot
 */

chatbotGetFlows([_, _, _, _, Flows], Flows).

/*
 Nombre: chatbotGetName/2
 Dominio: Chatbot, Name
 Descripci�n: Entrega el nombre del chatbot
 */


chatbotGetName([_, ChatbotName, _, _, _], ChatbotName).

/*
 Nombre: chatbotGetID/2
 Dominio: Chatbot, ID
 Descripci�n: Entrega el ID del chatbot
 */


chatbotGetID([ID, _, _, _, _], ID).

/*
 Nombre: chatbotGetMsg/2
 Dominio: Chatbot, Msg
 Descripci�n: Entrega el mensaje de bienvenida del chatbot
 */


chatbotGetMsg([_ , _, Msg, _, _], Msg).

/*
 Nombre: chatbotGetIDFlow/2
 Dominio: Chatbot, IDFlow
 Descripci�n: Entrega el ID del flujo inicial del chatbot
 */


chatbotGetIDFlow([_, _, _, FlowID, _], FlowID).
