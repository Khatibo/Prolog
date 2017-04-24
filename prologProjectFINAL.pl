:- use_module(library(clpfd)).

%check if the grid is correct
mycheck([]).
mycheck([l|[]]).
mycheck([l,r|_]).
mycheck([H|T]):-
H=w;H=c,
mycheck(T).


%turns a given list to a list of lists with given width%
list_to_llists([],_,[]).

list_to_llists(L,W,[H|T]):-
L=[_|_],
W1 is W-1,
sublist(0,W1,L,H),
length(L,Len),
length(H,W),
L1 is Len-1,
sublist(W,L1,L,Rest),
list_to_llists(Rest,W,T).

list_to_llists(L,W,[]):-
L=[_|_],
W1 is W-1,
sublist(0,W1,L,H),
length(H,W11),
W11<W.

%checks if a given list is a sublist of another list from I1 to I2
 sublist(_,_,[],[]).
sublist(I1,I2,_,[]):-I2\=0,I1>I2.
sublist(0,0,[A|_],[A]).
 sublist(I1,I2,[A|B],S):- 0 is I1,I2\=0, I1=<I2, NI2 is I2-1, S=[A|D], sublist(0,NI2,B,D).
sublist(I1,I2,[_A|B],S):- I1>0, I1=<I2,I11 is I1-1,I22 is I2-1,sublist(I11,I22,B,S).


%succeeds if element is present in the first of a list
getZeroth([H|T],El):-
                 member(El,[H]).

%succeeds if List 1 is the same as another list except first element
rest([],[]).
rest([H|T],R):-member(R,[T]).

%collects hints
at(5,0,w).
at(3,5,c).
at(9,6,c).
at(0,0,w).


%collect_hints(H):-
%length(H,N),
%N==4.
collect_hints([at(5,0,w),at(3,5,c),at(9,6,c)]).



%ensure_hints(L,Hints,W,H) // its n by n so we will check on the size by the modulus operator
%index of a certain point index=X+(Y*width) assuming all horizontal and vertical indexes start from zero

%ensures that hints are applicable on the grid
ensure_hints(L,Hints,W,H):-
sizeIsValid(L,H,W),
validHints(L,Hints,W).

%checks the hints size
sizeIsValid(L,H,W):-
length(L,X),
W1 is X /H,
W == W1.

%check the hints
validHints(L,[],W).

validHints(L,[at(X,Y,Type)|T],W):-
X1 is X+ Y*W,
nth0(X1,L,Type),
validHints(L,T,W).

generator(H):-
H=w;H=c;H=l;H=r.

%assigns all permutations of the given list
random_assignment([]).

random_assignment([H|T]):-
generator(H),
random_assignment(T).


%calculates how many times a certain element is present in a list
total(_, [], 0) :- !. /* empty list, base case */

total(X, [X|T], N) :- /* if X is in the head of the list */
    total(X, T, N2), /* count on the tail (let this N2) */
    N is N2 + 1.     /* and N is N2 + 1  */

total(X, [Y|T], N) :-
    X \= Y,          /* if X is not in the head */
    total(X, T, N).  /* just count the rest */

%multiplies by 2
multiplier(N,NN):-
NN is N*2.

%checks if the given total is the total of vessels in each row
check_rows([],W,H,Totals).
check_rows(L,W,H,Totals):-
list_to_llists(L,W,LL),
check_rowsHelper(LL,Totals).

check_rowsHelper([],[]).
check_rowsHelper([A|B],[H1|T]):-
(total(c,A,N1),total(l,A,N2)),
multiplier(N2,NN),
H1 is N1+NN,
check_rowsHelper(B,T).

%checks if the given total is the total of vessels in each column
check_columns([],W,H,Totals).
check_columns(L,W,H,_):-
length(L,N),N<W,L\=[].
check_columns(L,W,H,Totals):-
list_to_llists(L,W,LL),
transpose(LL,NLL),
check_columnsHelper(NLL,Totals).

check_columnsHelper([],[]).
check_columnsHelper([A|B],[H1|T]):-
(total(c,A,N1),total(l,A,N2),total(r,A,N3)),
H1 is N1+N2+N3,
check_columnsHelper(B,T).

%checks if the given total is the total of destroyers in the whole grid
check_destroyer([],_,_,_).
check_destroyer(L,W,H,TotalDestroyers):-

\+(check_for_r_in_first_place(L,W,r)),
check_destroyerHelper(L,N),
N==TotalDestroyers.

check_destroyerHelper(L,N2):-
total(l,L,N2).

%checks if there's an r vessel in the first of a list
check_for_r_in_first_place(L,W,E):-
list_to_llists(L,W,LL),
check_for_r_in_first_placeHelper(LL,E).

check_for_r_in_first_placeHelper([],_):-false.
check_for_r_in_first_placeHelper([A|B],E):-
nth0(0,A,E);
check_for_r_in_first_placeHelper(B,E).

%checks if the given total is the total of submarines in the whole grid
check_submarines([],_,_,_).
check_submarines(L,W,H,TotalSubmarines):-

check_submarinesHelper(L,N),
N==TotalSubmarines.

check_submarinesHelper(L,N2):-
total(c,L,N2).

%generates the grid by calling the necessary predicates
battleship(L,W,H,TotalSub,TotalDes,TotalRows,TotalColumns):-
ensure_hints(L,[at(0,0,w)],W,H),
check_submarines(L,W,H,TotalSub),
check_destroyer(L,W,H,TotalDes),
check_columns(L,W,H,TotalColumns),
check_rows(L,W,H,TotalRows).
