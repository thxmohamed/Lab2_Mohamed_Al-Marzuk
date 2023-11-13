:- consult('tdasystem_22594262_Al-Marzuk.pl').
:- consult('tdachathistory_22594262_Al-Marzuk.pl').

/*
 RF2: TDA Option (Constructor)

 Nombre: option/6

 Descripción: Predicado que crea una opción, que es una lista con los
 elementos del dominio

 Dominio: Code (Integer) X Message (String) X
 ChatbotCodeLink (Integer) X InitialFlowCodeLink (Integer) X Keywords
 (List) X Option (List)

 Metas Primarias: option/6

 Metas Secundarias: integer/1, string/1, is_list/1
 */

option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords,
       [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]) :-
    integer(Code), string(Message), integer(ChatbotCodeLink), integer(InitialFlowCodeLink),
    is_list(Keywords).

/*
 RF3: TDA Flow (Constructor)

 nombre: flow/4

 Descripción: Predicado que crea un Flow, que es una lista con los
 elementos del dominio

 Dominio: ID (Integer) X NameMsg (String) X Options (List) X Flow (List)

 Metas Primarias: flow/4

 Metas Secundarias: agregarSinDuplicados/3, integer/1, string/1,
 is_list/1
 */


flow(ID, NameMsg, Options, [ID, NameMsg, OptionsSinDuplicados]) :-
    agregarSinDuplicados(Options, [], OptionsSinDuplicados),
    integer(ID), string(NameMsg), is_list(Options).

/*
 RF4: TDA Flow (Modificador)

 Nombre: flowAddOption/3

 Descripción: Predicado que agrega una opción a un flow, siempre y
 cuando esta opción no esté ya dentro del flow

 Dominio: Flow X Option X Flow

 Metas Primarias: flowAddOption/3

 Secundarias: member/2
 */

flowAddOption([ID, NameMsg, Options], Option, [ID, NameMsg, [Option|Options]]) :-
    \+ member(Option, Options).

/*
  RF5: TDA Chatbot (Constructor)

  nombre: chatbot/6

  Descripción: Predicado que crea un Chatbot, que es una lista con los
  elementos del dominio

  Dominio: ChatbotID (Integer) X ChatbotName (String) X WelcomeMsg
  (String) X StartFlowID X Flows (List) X Chatbot (List)

  Metas Primarias: chatbot/6

  Metas Secundarias: agregarSinDuplicados/3, integer/1, string/1,
  is_list/1
  */

chatbot(ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, Flows,
        [ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, FlowsSinDuplicados]) :-
    agregarSinDuplicados(Flows, [], FlowsSinDuplicados),
    integer(ChatbotID), string(ChatbotName), string(WelcomeMsg), integer(StartFlowID), is_list(Flows).

/*
  RF6: TDA Chatbot (Modificador)

  nombre: chatbotAddFlow/3

  Descripción: Predicado que añade un flujo a un chatbot de
  manera recursiva

  Recursión usada: De cola

  Dominio: Chatbot X Flow

  Metas Primarias: chatbotAddFlow/3

  Metas Secundarias: member/2
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

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [PrimerFlow|RestoDeFlows]], Flow, Chatbot2) :-
    \+ member(PrimerFlow, [Flow]),
    chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, RestoDeFlows], [[PrimerFlow]|Flow], Chatbot2).

chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, [PrimerFlow|RestoDeFlows]], Flow, Chatbot2) :-
    member(PrimerFlow, [Flow]),
    chatbotAddFlow([ChatbotID, ChatbotName, WelcomeMsg, StartFlowID, RestoDeFlows], Flow, Chatbot2).

/*
 RF7: TDA System (Constructor)

 nombre: system/4

 Descripción: Predicado que crea un System, que es una lista con los
 elementos del dominio, y tres listas adicionales, siendo la primera una
 lista de los usuarios registrados, la segunda una lista vacía
 que guarda al usuario loggeado, y la tercera una lista con el
 chathistory de cada usuario.

 Dominio: Name (String) X InitialChatbotCode (Integer) X Chatbots (List)
 X System (List)

 Metas Primarias: system/4

 Metas Secundarias: agregarSinDuplicados/3, string/1, integer/1, is_list/1
*/


system(Name, InitialChatbotCode, Chatbots, [Name, InitialChatbotCode, [], [], [], ChatbotsSinDuplicados]) :-
    agregarSinDuplicados(Chatbots, [], ChatbotsSinDuplicados),
    string(Name), integer(InitialChatbotCode), is_list(Chatbots).

/*
 RF8: TDA System (Modificador)

 nombre: systemAddChatbot/3

 Descripción: Predicado que agrega un chatbot a un Sistema

 Dominio: System X Chatbot X NewSystem

 Metas Primarias: systemAddChatbot/3

 Metas Secundarias: member/2
 */

systemAddChatbot([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], Chatbot,
                 [Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory,[Chatbot|Chatbots]]) :-
    \+ member(Chatbot, Chatbots).

/*
 RF9: TDA System (Modificador)

 nombre: systemAddUser/3

 Descripción: Predicado que agrega un user a un Sistema

 Dominio: System X User (String) X NewSystem

 Metas Primarias: systemAddUser/3

 Metas Secundarias: member/2
 */

systemAddUser([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], User,
             [Name, InitialChatbotCode, [User|RegisteredUsers], LoggedUser, [[User]|ChatHistory], Chatbots]) :-
    \+ member(User, RegisteredUsers).

/*
 RF10: TDA System (Modificador)

 nombre: systemLogin/3

 Descripción: Predicado que loggea a un usuario en un sistema

 Dominio: System X User (String) X NewSystem

 Metas Primarias: systemLogin/3

 Metas Secundarias: member/2
 */

systemLogin([Name, InitialChatbotCode, RegisteredUsers, [], ChatHistory, Chatbots], User,
           [Name, InitialChatbotCode, RegisteredUsers, User, ChatHistory, Chatbots]) :-
    member(User, RegisteredUsers).

/*
 RF11: TDA System (Modificador)

 nombre: systemLogout/2

 Descripción: Predicado que desloggea a un usuario en un sistema

 Dominio: System X NewSystem

 Metas Primarias: systemLogout/2

 Metas Secundarias: string/1
 */

systemLogout([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots],
             [Name, InitialChatbotCode, RegisteredUsers, [], ChatHistory, Chatbots]) :-
    string(LoggedUser).

/*
 RF12: TDA System (Modificador)

 nombre: systemTalkRec/3

 Descripción: Predicado que sirve para interactuar con un chatbot

 Dominio: System X Msg (String) X NewSystem

 Metas Primarias: systemTalkRec/3

 Metas Secundarias: systemGetChatbotID/2, systemFindChatbot/3,
 systemGetIDFlow/2, systemChatbotSearch/3, systemAddChatHistory/3,
 systemAddChatbotMsg/3, chatbotFindFlow/3, chatbotGetName/2,
 flowGetName/2, systemUpdateChatbotID/3, systemUpdateChatbotList/4
 */

% Sistema no iniciado, se asume que el primer mensaje ingresado por el
% usuario es "hola", en este caso, se mostrarán las opciones del chatbot
% inicial y del flujo inicial

systemTalkRec(System, "hola", NewSystem) :-
    systemGetChatbotID(System, InitialChatbotCode),
    systemFindChatbot(System, InitialChatbotCode, Chatbot),
    chatbotGetIDFlow(Chatbot, IDFlow),
    systemChatbotSearch(System, [InitialChatbotCode, IDFlow], List),
    systemAddChatHistory(System, "hola", SystemAux),
    systemAddChatbotMsg(SystemAux, List, NewSystem).

% Sistema iniciado, el mensaje es una keyword, en este caso, se buscan
% los id del chatbot y flujo asociados a la keyword, se actualizan en el
% sistema y se muestran las opciones del nuevo flujo

systemTalkRec(System, KeyWord, NewSystem) :-
    systemGetChatbotID(System, CurrentChatbotID),
    systemGetLoggedUser(System, LoggedUser), \+ isNull(LoggedUser),
    systemFindChatbot(System, CurrentChatbotID, CurrentChatbot),
    chatbotGetIDFlow(CurrentChatbot, CurrentFlowID),
    chatbotFindFlow(CurrentChatbot, CurrentFlowID, CurrentFlow),
    flowIdsFilter(CurrentFlow, KeyWord, [CbID, FlowID]),
    systemFindChatbot(System, CbID, NewChatbot),
    chatbotFindFlow(NewChatbot, FlowID, NewFlow),
    systemUpdateChatbotID(System, CbID, System2),
    systemUpdateChatbotList(System2, CbID, FlowID, System3),
    systemAddChatHistory(System3, KeyWord, System4),
    flowOptionSearch(NewFlow, Options),
    chatbotGetName(NewChatbot, CbName), flowGetName(NewFlow, MsgFlow),
    systemAddChatbotMsg(System4, [CbName, " ", MsgFlow, "\n" | Options], NewSystem).

% Sistema iniciado, mensaje es un string numerico, en este caso, se
% busca el id de la opción dentro del flujo actual que coincida con el
% numero, se extraen las ids del chatbot y flujo asociados a la opcion,
% se actualizan en el sistema y se muestran las opciones del nuevo flujo

systemTalkRec(System, Num, NewSystem) :-
    number_codes(Number, Num), integer(Number),
    systemGetChatbotID(System, CurrentChatbotID),
    systemGetLoggedUser(System, LoggedUser), \+ isNull(LoggedUser),
    systemFindChatbot(System, CurrentChatbotID, CurrentChatbot),
    chatbotGetIDFlow(CurrentChatbot, CurrentFlowID),
    chatbotFindFlow(CurrentChatbot, CurrentFlowID, CurrentFlow),
    flowIdsFilterNum(CurrentFlow, Num, [CbID, FlowID]),
    systemFindChatbot(System, CbID, NewChatbot),
    chatbotFindFlow(NewChatbot, FlowID, NewFlow),
    systemUpdateChatbotID(System, CbID, System2),
    systemUpdateChatbotList(System2, CbID, FlowID, System3),
    systemAddChatHistory(System3, Num, System4),
    flowOptionSearch(NewFlow, Options),
    chatbotGetName(NewChatbot, CbName), flowGetName(NewFlow, MsgFlow),
    systemAddChatbotMsg(System4, [CbName, " ", MsgFlow, "\n" | Options], NewSystem).

/*
 RF13: TDA System (Modificador)

 nombre: systemSynthesis/3

 Descripción: Predicado que sirve para convertir el chathistory de un
 usuario en un string

 Dominio: System X User (String) X String

 Metas Primarias: systemSynthesis/3

 Metas Secundarias: systemUserIsRegistered/2, systemFindUserChat/3,
 chatHistoryConcat/2
 */

% Caso en el que el usuario no se encuentra registrado en el sistema,
% retorna "Usuario no encontrado"

systemSynthesis(System, User, "Usuario no encontrado") :-
    \+ systemUserIsRegistered(System, User).

% Caso en el que el usuario se encuentra registrado, retorna todo su
% historial. Si se encuentra registrado pero no ha hablado nunca,
% retorna un string vacio

systemSynthesis(System, User, String) :-
    systemUserIsRegistered(System, User),
    systemFindUserChat(System, User, [User|ChatHistory]),
    chatHistoryConcat(ChatHistory, String).

