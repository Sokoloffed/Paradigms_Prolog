﻿implement main
    open core

domains
    list = integer*.

class predicates
    negative : (list, integer, list [out]) multi.
    kuzenko : (integer, list, integer [out]) multi.
    shysh : (list, list, list [out]) nondeterm.

clauses
    kuzenko(_, [], 0).

    kuzenko(H1, [H2 | T2], Counter) :-
        H1 = H2,
        kuzenko(H1, T2, Counter1),
        Counter = Counter1 + 1.

    kuzenko(H1, [H2 | T2], Counter) :-
        kuzenko(H1, T2, Counter).

    shysh([], _, []).
    shysh([Head1 | Tail1], [Head2 | Tail2], Res) :-
        kuzenko(Head1, [Head2 | Tail2], Counter),
        Counter = 3,
        shysh(Tail1, [Head2 | Tail2], Res1),
        Res = [Head1 | Res1].
    shysh([Head1 | Tail1], [Head2 | Tail2], Res) :-
        kuzenko(Head1, [Head2 | Tail2], Counter),
        shysh(Tail1, [Head2 | Tail2], Res).

    negative([], _, []).

    negative([Head | Tail], Counter, Res) :-
        Head < 0,
        negative(Tail, Counter + 1, Res1),
        Res = [Counter | Res1].

    negative([Head | Tail], Counter, Res) :-
        negative(Tail, Counter + 1, Res).

clauses
    run() :-
        console::init(),
        negative([1, 2, -1, 3, 4, -5], 0, Res),
        T = list::length(Res),
        stdio::nl,
        console::write(T),
        stdio::write(Res),
        shysh([1, 1, 2, 1, 2, 3, 4, 2, 6, 7, 8, 44, 4, 4], [1, 1, 2, 1, 2, 3, 4, 2, 6, 7, 8, 44, 4, 4], Res2),
        Y = list::removeDuplicates(Res2),
        stdio::nl,
        stdio::write(Y),
        !,
        console::write("Normal")
        or
        console::write("Fail"),
        console::clearinput(),
        _ = console::readChar().

end implement main

goal
    mainExe::run(main::run).
