/*
 Nombre: createUserHistory/4

 Dominio: Time (Float), Sender (String), Msg (String), History (List)

 Descripción: Entrega una lista que contiene los elementos del dominio,
 que representan un mensaje de un usuario

 Metas Primarias: createUserHistory/4

 Metas Secundarias: number_codes/2, atom_codes/2
 */

createUserHistory(Time, Sender, Msg, History) :-
    number_codes(Time, AuxTime), atom_codes(TimeText, AuxTime),
    History = [ TimeText, " ", Sender, ": ", Msg, "\n\n"].

/*
 Nombre: createChatbotHistory/4

 Dominio: Time (Float), Sender (String), Msg (String), History (List)

 Descripción: Entrega una lista que contiene los elementos del dominio,
 que representan un mensaje de un chatbot

 Metas primarias: createChatbotHistory/4

 Metas secundarias: number_codes/2, atom_codes/2
 */

createChatbotHistory(Time, Sender, Msg, History) :-
    number_codes(Time, AuxTime), atom_codes(TimeText, AuxTime),
    History = [ TimeText, " ", Sender, ": ", Msg, "\n\n"].

/*
 Nombre: textListConcatenate/2

 Dominio: List X String

 Descripción: concatena en un string unico una lista de strings

 Recursion Usada: Natural

 Metas primarias: textListConcatenate/2

 Metas secundarias: string_concat/3
*/

chatMsgConcat([], "").

chatMsgConcat([PrimerString|RestoStrings], Texto) :-
    chatMsgConcat(RestoStrings, RestoTexto),
    string_concat(PrimerString, RestoTexto, Texto).

/*
 Nombre: chatHistoryConcat/2

 Dominio: MsgList X String

 Descripción: concatena en un string unico una lista de mensajes

 Recursion Usada: Natural

 Metas primarias: chatHistoryConcat/2

 Metas secundarias: textListConcat/2, chatHistoryConcat/2,
 string_concat/3
*/

chatHistoryConcat([], "").

chatHistoryConcat([Msg1|RestoMsg], Texto) :-
    chatMsgConcat(Msg1, PrimerText),
    chatHistoryConcat(RestoMsg, RestoText),
    string_concat(PrimerText, RestoText, Texto).

