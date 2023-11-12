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
 Metas Primarias: Construir option
 Metas Secundarias: Comprobar si los elementos de la lista cumplen
 con los elementos del dominio
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
 Metas Primarias: Construir Flow
 Metas Secundarias: Comprobar si los elementos de la lista
 cumplen con los elementos del dominio
*/


flow(ID, NameMsg, Options, [ID, NameMsg, OptionsSinDuplicados]) :-
    agregarSinDuplicados(Options, [], OptionsSinDuplicados),
    integer(ID), string(NameMsg), is_list(Options).

/*
 RF4: TDA Flow (Modificador)
 Nombre: flowAddOption/3
 Descripción: Predicado que agrega una opción a un flow, siempre y
 cuando esta opción no esté ya dentro del flow
 Dominio: Flow X Option
 Metas Primarias: Agregar una opción a un flow
 Secundarias: Comprobar si la opción a agregar está dentro del flow
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
  Metas Primarias: Construir Chatbot
  Metas Secundarias: Comprobar si los elementos de la
  lista cumplen con los elementos del dominio. Comprobar si los flows a
  añadir están duplicados.
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
 Metas Primarias: Construir System
 Metas Secundarias: Comprobar si los elementos de la lista cumplen con
 los elementos del dominio
*/


system(Name, InitialChatbotCode, Chatbots, [Name, InitialChatbotCode, [], [], [], ChatbotsSinDuplicados]) :-
    agregarSinDuplicados(Chatbots, [], ChatbotsSinDuplicados),
    string(Name), integer(InitialChatbotCode), is_list(Chatbots).

/*
 RF8: TDA System (Modificador)
 nombre: systemAddChatbot/3
 Descripción: Predicado que agrega un chatbot a un Sistema
 Dominio: System X Chatbot X NewSystem
 Metas Primarias: Agregar Chatbot a un System
 Metas Secundarias: Comprobar si el Chatbot ya se encuentra dentro del System
 */

systemAddChatbot([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], Chatbot,
                 [Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory,[Chatbot|Chatbots]]) :-
    \+ member(Chatbot, Chatbots).

/*
 RF9: TDA System (Modificador)
 nombre: systemAddUser/3
 Descripción: Predicado que agrega un user a un Sistema
 Dominio: System X User (String) X NewSystem
 Metas Primarias: Agregar User a un System
 Metas Secundarias: Comprobar si el User ya se encuentra dentro del
 System
 */

systemAddUser([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], User,
             [Name, InitialChatbotCode, [User|RegisteredUsers], LoggedUser, [[User]|ChatHistory], Chatbots]) :-
    \+ member(User, RegisteredUsers).

/*
 RF10: TDA System (Modificador)
 nombre: systemLogin/3
 Descripción: Predicado que loggea a un usuario en un sistema
 Dominio: System X User (String) X NewSystem
 Metas Primarias: Loggear User a un sistema
 Metas Secundarias: Comprobar si el User ya se encuentra dentro del
 sistema, comprobar si ya hay un usuario loggeado en el sistema
 */

systemLogin([Name, InitialChatbotCode, RegisteredUsers, [], ChatHistory, Chatbots], User,
           [Name, InitialChatbotCode, RegisteredUsers, User, ChatHistory, Chatbots]) :-
    member(User, RegisteredUsers).

/*
 RF11: TDA System (Modificador)
 nombre: systemLogout/2
 Descripción: Predicado que desloggea a un usuario en un sistema
 Dominio: System X NewSystem
 Metas Primarias: Desloggear User a un sistema
 Metas Secundarias: Comprobar si el User ya se encuentra loggeado dentro
 del sistema.
 */

systemLogout([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots],
             [Name, InitialChatbotCode, RegisteredUsers, [], ChatHistory, Chatbots]) :-
    string(LoggedUser).

