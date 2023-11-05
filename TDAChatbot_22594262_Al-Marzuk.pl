%Aquí van las funciones del TDA Chatbot
/* 
  RF5: TDA Chatbot (Constructor) 
  Descripción: Predicado que crea un Chatbot, que es una lista con los 
  elementos del dominio 
  Dominio: ChatbotID (Integer) X ChatbotName (String) X WelcomeMsg (String) X StartFlowID X Flows (List) 
  Metas Primarias: Construir Chatbot
  Metas Secundarias: Comprobar si los elementos de la lista
  cumplen con los elementos del dominio. Comprobar si los flows a añadir están duplicados.
 */

chatbot(ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, Flows,
        [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, FlowsSinDuplicados]) :-
    agregarSinDuplicados(Flows, [], FlowsSinDuplicados),
    integer(ChatbotID), string(ChatbotName), string(WelcomeMsg), integer(StartFlowID), is_list(Flows).

%aca ira el RF6
%caso basr

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, []], Flow, [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [Flow]]).
