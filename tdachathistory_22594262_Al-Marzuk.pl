/*
 Nombre: createUserHistory/4
 Dominio: Time (Float), Sender (String), Msg (String), History (List)
 Descripción: Entrega una lista que contiene los elementos del dominio,
 que representan un mensaje de un usuario
 */

createUserHistory(Time, Sender, Msg, History) :-
    number_codes(Time, AuxTime), atom_codes(TimeText, AuxTime),
    History = [ TimeText, " ", Sender, ": ", Msg, "\n\n"].

/*
 Nombre: createUserHistory/4
 Dominio: Time (Float), Sender (String), Msg (String), History (List)
 Descripción: Entrega una lista que contiene los elementos del dominio,
 que representan un mensaje de un chatbot
 */

createChatbotHistory(Time, Sender, Msg, History) :-
    number_codes(Time, AuxTime), atom_codes(TimeText, AuxTime),
    History = [ TimeText, " ", Sender, ": ", Msg, "\n\n"].

/*
 Nombre: textListConcatenate/2
 Dominio: List X String
 Descripción: concatena en un string unico una lista de strings
 Recursion Usada: Natural
 Metas primarias: concatenar lista de strings
 Metas secundarias: no aplica
*/

textListConcatenate([], "").

textListConcatenate([PrimerString|RestoStrings], Texto) :-
    textListConcatenate(RestoStrings, RestoTexto),
    string_concat(PrimerString, RestoTexto, Texto).

/*
 Nombre: chatHistoryConcat/2
 Dominio: MsgList X String
 Descripción: concatena en un string unico una lista de mensajes
 Recursion Usada: Natural
 Metas primarias: concatenar lista de strings
 Metas secundarias: no aplica
*/

chatHistoryConcat([], "").

chatHistoryConcat([Msg1|RestoMsg], Texto) :-
    textListConcatenate(Msg1, PrimerText),
    chatHistoryConcat(RestoMsg, RestoText),
    string_concat(PrimerText, RestoText, Texto).

