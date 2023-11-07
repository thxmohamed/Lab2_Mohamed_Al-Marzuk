
/*
  RF5: TDA Chatbot (Constructor)
  Descripción: Predicado que crea un Chatbot, que es una lista con los
  elementos del dominio
  Dominio: ChatbotID (Integer) X ChatbotName (String) X WelcomeMsg (String) X StartFlowID X Flows (List)
  Metas Primarias: Construir Chatbot
  Metas Secundarias: Comprobar si los elementos de la lista
  cumplen con los elementos del dominio. Comprobar si los flows a
  añadir están duplicados.
 */

chatbot(ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, Flows,
        [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, FlowsSinDuplicados]) :-
    agregarSinDuplicados(Flows, [], FlowsSinDuplicados),
    integer(ChatbotID), string(ChatbotName), string(WelcomeMsg), integer(StartFlowID), is_list(Flows).


/*
  RF6: TDA Chatbot (Modificador)
  Descripción: Predicado que añade un flujo a un chatbot de
  manera recursiva
  Recursión usada: De cola
  Dominio: Chatbot X Flow
  Metas Primarias: Añadir flujo a un chatbot
  Metas Secundarias: Comprobar si la lista de flujos tiene elementos, o
  si el flujo a añadir está ya añadido.
 */

% Caso Base: La lista de flows está vacía, así que se añade el flow sin
% ningún problema.

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, []], Flow, [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [Flow]]).

% Caso recursivo: La lista de flows no está vacía, así que se separa en
% el primer flow y en el resto. se comprueba si el primer flow está
% presente en ListFlows (que será la lista de flows final), en ese caso,
% se avanza la recursión con el resto de flows, y si no está presente,
% se añade a ListFlows y se avanza con el resto. Así hasta llegar al
% caso base en el que ya no hay más flows en el chatbot, y se añade
% ListFlows

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [PrimerFlow|RestoDeFlows]], ListFlows, Chatbot2) :-
    \+ member(PrimerFlow, ListFlows),
    chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, RestoDeFlows], [PrimerFlow|ListFlows], Chatbot2).

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [PrimerFlow|RestoDeFlows]], ListFlows, Chatbot2) :-
    member(PrimerFlow, ListFlows),
    chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, RestoDeFlows], ListFlows, Chatbot2).

