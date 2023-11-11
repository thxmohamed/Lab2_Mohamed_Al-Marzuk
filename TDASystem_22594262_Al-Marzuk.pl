use_module(TDAFlow_22594262_almarzuk, agregarSinDuplicados/3).

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
                 [Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots]) :-
    member(Chatbot, Chatbots).

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
             [Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots]) :-
    member(User, RegisteredUsers).

systemAddUser([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], User,
             [Name, InitialChatbotCode, [User|RegisteredUsers], LoggedUser, [[User]|ChatHistory], Chatbots]) :-
    \+ member(User, RegisteredUsers).

/*
 nombre: isNull/1
 Descripción: Se declara un hecho, isNull retorna true si se le pasa una
 lista vacía como argumento
 Dominio: Cualquier cosa
    */

isNull([]).

/*
 RF10: TDA System (Modificador)
 nombre: systemLogin/3
 Descripción: Predicado que loggea a un usuario en un sistema
 Dominio: System X User (String) X NewSystem
 Metas Primarias: Agregar User a un sistema
 Metas Secundarias: Comprobar si el User ya se encuentra dentro del
 sistema, comprobar si ya hay un usuario loggeado en el sistema
 */


systemLogin([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], User,
           [Name, InitialChatbotCode, RegisteredUsers, User, ChatHistory, Chatbots]) :-
    member(User, RegisteredUsers), isNull(LoggedUser).

systemLogin([Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots], User,
           [Name, InitialChatbotCode, RegisteredUsers, LoggedUser, ChatHistory, Chatbots]) :-
    \+ member(User, RegisteredUsers) ; \+ isNull(LoggedUser).
