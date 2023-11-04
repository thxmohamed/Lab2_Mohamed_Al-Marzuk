%Aquí van las funciones del TDA Chatbot

chatbot(ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, Flows,
        [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, FlowsSinDuplicados]) :-
    agregarSinDuplicados(Flows, [], FlowsSinDuplicados),
    integer(ChatbotID), string(ChatbotName), string(WelcomeMsg), integer(StartFlowID), is_list(Flows).
