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
 Metas Primarias: Construir Flow Metas Secundarias:
 Comprobar si los elementos de la lista cumplen con los elementos del
 dominio
*/


system(Name, InitialChatbotCode, Chatbots, [Name, InitialChatbotCode, [], [], [], ChatbotsSinDuplicados]) :-
    agregarSinDuplicados(Chatbots, [], ChatbotsSinDuplicados),
    string(Name), integer(InitialChatbotCode), is_list(Chatbots).
