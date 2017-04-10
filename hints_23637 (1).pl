maplist(P, [], []).
maplist(P, [X|Xs], [Y|Ys]) :-
        call(P, X, Y),
        maplist(P, Xs, Ys).
		
pretty_print([],_,_).                                                                                                                                      
pretty_print([Head|Tail],W,H):-
                        %print(pretty_print_h(W,[Head|Tail],L1)),
                        pretty_print_h([Head|Tail],W,L1),
                        pretty_print(L1,W,H).
 
pretty_print_h(Rest,0,Rest):-nl.
pretty_print_h([],N,[]):-N>0,nl.
pretty_print_h([H|T],W,Rest):-
                            W>0,
                            print(H),print(' '),
                            W1 is W -1 ,
                            pretty_print_h(T,W1,Rest).