

%checking the structure of the map
mycheck([]). % if its empty
mycheck([_,_]). %normal list
mycheck([l,r|_]).% if there is an l there must be an r
mycheck([_|l]).% if there is an l *i.e part of a grid * it must be the last elements


%list_to_llisst if memberrs of L are in LLists and all sublists in LL have width  W



%list_to_llists(L,W,LLists)

list_to_llists(L,W,LLists):-
flatten(LLists,L1), %converts nested lists to a 1d list
restHelper(L,L1). %checking if all elements are present in L1
%list_to_llistsLengthCheck(W,LLists).



list_to_llistsLengthCheck(_,[_|[]]).
list_to_llistsLengthCheck(W,[H|T]):-
length(H,W),
list_to_llistsLengthCheck(W,T).






memberHelper(X,[[X|_]|_]). %takes a member and a list of lists and check if the member is present in the first positon on the sublist

memberHelper(X,[[_|T1]|B]):- %takes a member and a list of lists and check if the member is present in one of the lists
member(X,T1);memberHelper(X,B).

%gerZero0th if E1 is the first elements of the input list
getZeroth([E1|_],E1).

%rest if the rest list is equal to the tail of the main list
%rest(L,R)

rest([_|T],R):-
restHelper(T,R). %check if the tail is equal to R or not


restHelper([],[]).
restHelper([H|T],R):- % all members of the left side list must be in R.
member(H,R),
restHelper(T,R).

%sublist checks if a given list is a sublist of another list from I1 to I2
 sublist(_,_,[],[]).
sublist(0,0,[A|_],[A]).
 sublist(I1,I2,[A|B],S):- 0 is I1, I1=<I1, NI2 is I2-1, S=[A|D], sublist(0,NI2,B,D).
sublist(I1,I2,[_A|B],S):- I1>0, I1=<I2, sublist(I1-1,I2-1,B,S).
