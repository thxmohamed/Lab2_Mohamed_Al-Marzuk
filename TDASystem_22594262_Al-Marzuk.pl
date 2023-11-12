:- consult('tdachatbot_22594262_Al-Marzuk.pl').
:- consult('tdachathistory_22594262_Al-Marzuk.pl').

/*
 Nombre: systemGetName/2
 Dominio: System, Name (String)
 Descripción: Entrega el nombre del System
 */

systemGetName([Name|_], Name).

/*
 Nombre: systemGetChatbotID/2
 Dominio: System, ChatbotID (Integer)
 Descripción: Entrega el chatbot inicial del System
 */

systemGetChatbotID([_, ChatbotID, _, _, _, _], ChatbotID).

/*
 Nombre: systemGetRegisteredUsers/2
 Dominio: System, RegisteredUsers (List)
 Descripción: Entrega la lista de usuarios registrados del System
 */

systemGetRegisteredUsers([_, _, RegisteredUsers, _, _, _], RegisteredUsers).

/*
 Nombre: systemGetLoggedUser/2
 Dominio: System, LoggedUser (String)
 Descripción: Entrega el usuario loggeado en el System
 */

systemGetLoggedUser([_, _, _, LoggedUser, _, _], LoggedUser).

/*
 Nombre: systemGetChatHistory/2
 Dominio: System, ChatHistory (List)
 Descripción: Entrega el chatHistory de todos los usuarios
 */

systemGetChatHistory([_, _, _, _, ChatHistory, _], ChatHistory).

/*
 Nombre: systemGetChatbots/2
 Dominio: System, Chatbots (List)
 Descripción: Entrega una lista de todos los chatbots del sistema
 */

systemGetChatbots([_, _, _, _, _, Chatbots], Chatbots).

/*
 Nombre: systemFindUserChat/3
 Dominio: System, User (string), History (List)
 Descripción: Regla recursiva que entrega el ChatHistory de un usuario
 en específico.
 Recursión usada: De cola
 Metas primarias: Encontrar el historial del usuario
 Metas secundarias: no aplica
*/

% Condición de borde, no hay más usuarios, retorna una lista vacía

systemFindUserChat([_, _, _, _, [], _], _, []).

% segunda condición de parada, el primer usuario es el que busco,
% retorno una lista con su historial

systemFindUserChat([_, _, _, _, [[UserChat|Chat]|_], _], User, History):-
    UserChat == User,
    History = [UserChat|Chat].

% caso recursivo, busco en el resto de Chats

systemFindUserChat([_, _, _, _, [_|RestoChats], _], User, History):-
    systemFindUserChat([_, _, _, _, RestoChats, _], User, History).

/*
 Nombre: systemChatbotSearch/3
 Dominio: System, [IDChatbot, IDFlow] (List), List
 Descripción: Regla recursiva que entrega una lista con el
 nombre del Chatbot, el mensaje de bienvenida del chatbot y las
 opciones del flujo inicial de ese chatbot
 Recursión usada: De cola
 Metas primarias: Entregar una lista con lo que se mencionó
 Metas secundarias: no aplica
*/

% Condición de parada, no hay chatbots en el sistema, devuelvo una lista
% vacía
systemChatbotSearch(System, _, []) :-
    systemGetChatbots(System, Chatbots),
    isNull(Chatbots).

% segunda condición de parada, el chatbot coincide en ID, por lo que se
% buscan las opciones del flujo, el nombre y el mensaje de bienvenida
% del chatbot
systemChatbotSearch(System, [IdChatbot, IdFlow], OutList) :-
    systemGetChatbots(System, [Cb1 | _]),
    chatbotGetID(Cb1, ID),
    ID = IdChatbot,
    chatbotGetName(Cb1, Name),
    chatbotGetMsg(Cb1, Msg),
    chatbotFlowSearch(Cb1, IdFlow, Options),
    OutList = [Name, "\n", Msg, "\n" | Options].

% Caso recursivo, busco en el resto de chatbots
systemChatbotSearch(System, [IdChatbot, IdFlow], OutList) :-
    systemGetChatbots(System, [_ | RestoChatbots]),
    systemChatbotSearch([_, _, _, _, _, RestoChatbots], [IdChatbot, IdFlow], OutList).

/*
 Nombre: systemFindChatbot/3
 Dominio: System, ID chatbot (Integer), Chatbot
 Descripción: Regla recursiva que entrega un chatbot en base a
 su ID
 Recursión usada: De cola
 Metas primarias: Encontrar el historial del usuario
 Metas secundarias: no aplica
*/

%Condicion de parada, no hay más chatbots, retorna una lista vacía
systemFindChatbot([_, _, _, _, _, []], _, []).

% segunda condicion de parada, el chatbot coincide en ID, devuelvo ese
% chatbot
systemFindChatbot([_, _, _, _, _, [Chatbot1|_]], IDChatbot, Chatbot) :-
    chatbotGetID(Chatbot1, ID),
    ID == IDChatbot,
    Chatbot = Chatbot1.

%Caso recursivo, busco en el resto de chatbots
systemFindChatbot([_, _, _, _, _, [_|RestoChatbots]], IDChatbot, Chatbot):-
    systemFindChatbot([_, _, _, _, _, RestoChatbots], IDChatbot, Chatbot).

/*
 Nombre: systemUpdateChatbotID/3
 Dominio: System, ID chatbot (Integer), NewSystem
 Descripción: actualiza el ID del chatbot actual del sistema
 Metas primarias: Actualizar el ID
 Metas secundarias: no aplica
*/


systemUpdateChatbotID([Name, _, RegisteredUsers, LoggedUser, ChatHistory, Chatbots],
                      NewID,
                      [Name, NewID, RegisteredUsers, LoggedUser, ChatHistory, Chatbots]).

/*
 Nombre: systemUpdateChatbotList/4
 Dominio: System, ID chatbot (Integer), ID Flow (Integer), NewSystem
 Descripción: actualiza el ID del flujo actual deun chatbot en base a su
 ID, y lo guarda dentro del mismo sistema
 Metas primarias: Actualizar el ID del flow
 Metas secundarias: actualizar sistema
*/

systemUpdateChatbotList([Name, ChatbotID, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], IDChatbot, IDFlow,
                       [Name, ChatbotID, RegisteredUsers, LoggedUser, ChatHistory, NewChatbots]) :-
    systemFindChatbot([Name, ChatbotID, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], IDChatbot, Chatbot),
    select(Chatbot, Chatbots, AuxChatbots),
    chatbotUpdateFlowID(Chatbot, IDFlow, NewChatbot),
    append(AuxChatbots, [NewChatbot], NewChatbots).

/*
 Nombre: systemAddChatHistory/3
 Dominio: System, Msg (String), NewSystem
 Descripción: Agrega un mensaje al ChatHistory del usuario loggeado en
 el sistema
 Metas primarias: Agregar mensaje al historial
 Metas secundarias: Obtener tiempo, crear mensaje, comprobar que hay
 alguien loggeado en el sistema
*/

systemAddChatHistory(System, Msg, NewSystem):-
    systemGetLoggedUser(System, LoggedUser),
    \+ isNull(LoggedUser),
    systemFindUserChat(System, LoggedUser, CurrentHistory),
    get_time(Time),
    createUserHistory(Time, LoggedUser, Msg, AddHistory),
    systemGetChatHistory(System, ChatHistory),
    select(CurrentHistory, ChatHistory, NewChat),
    append(CurrentHistory, [AddHistory], NewHistory),
    append(NewChat, [NewHistory], NewChatHistory),
    systemGetName(System, Name),
    systemGetChatbotID(System, CbID),
    systemGetRegisteredUsers(System, Registered),
    systemGetChatbots(System, Chatbots),
    NewSystem = [Name, CbID, Registered, LoggedUser, NewChatHistory, Chatbots].

/*
 Nombre: systemAddChatbotMsg/3
 Dominio: System, Msg (List), NewSystem
 Descripción: Agrega un mensaje al ChatHistory del usuario loggeado en
 el sistema
 Metas primarias: Agregar mensaje del chatbot al historial
 Metas secundarias: Obtener tiempo, crear mensaje, comprobar que hay
 alguien loggeado en el sistema, concatenar el mensaje del chatbot en un
 unico string
*/


systemAddChatbotMsg(System, [NameChatbot|Resto], NewSystem) :-
    systemGetName(System, Name),
    systemGetChatbotID(System, CbID),
    systemGetRegisteredUsers(System, Registered),
    systemGetLoggedUser(System, Logged),
    systemGetChatHistory(System, ChatHistory),
    systemGetChatbots(System, Chatbots), \+ isNull(Logged),
    systemFindUserChat(System, Logged, CurrentHistory), get_time(Time),
    select(CurrentHistory, ChatHistory, AuxHistory),
    atomic_list_concat(Resto, Text),
    createChatbotHistory(Time, NameChatbot, Text, AddHistory),
    append(CurrentHistory, [AddHistory], Aux2),
    append(AuxHistory, [Aux2], NewChatHistory),
    NewSystem = [Name, CbID, Registered, Logged, NewChatHistory, Chatbots].

