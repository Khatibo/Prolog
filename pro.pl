%checks whether a list contains a left vessel followed by right vessel
mycheck([]).
mycheck([H1,H2|T]):-
(H1=l,H2=r);
mycheck([H2|T]).

%turns a given list to a list of lists with given width
list_to_llist([], _W, []).
list_to_llist(L, W, LL) :-
    list_to_llist_helper(L, 1, W, LL).

list_to_llist_helper([H|T], W, W, [[H]|LL]):-
    list_to_llist(T, W, LL).

list_to_llist_helper([H|T], W1 , W, [[H|TMP]|LL]):-
    W2 is W1 + 1,
    list_to_llist_helper(T, W2 , W, [TMP|LL]).

%checks if a given list is a sublist of another list from I1 to I2
 sublist(_,_,[],[]).
sublist(0,0,[A|_],[A]).
 sublist(I1,I2,[A|B],S):- 0 is I1, I1=<I1, NI2 is I2-1, S=[A|D], sublist(0,NI2,B,D).
sublist(I1,I2,[_A|B],S):- I1>0, I1=<I2, sublist(I1-1,I2-1,B,S).


%succeeds if element is present in the first of a list
getZeroth([H|_],El):-
                 member(El,[H]).

%succeeds if List 1 is the same as another list except first element
rest([_|T],R):-member(R,[T]).

%collects hints
%collect_hints(H).


random_assignment(L):-
member(w,L);
member(c,L);
member(l,L);
member(r,L).
