% Farkhad Gapparov 500718721, Sec 052
% Mohib Abdullah 500715782

print_solution :-
    solve([P,VP,S,T]),
    write('The President is '), write(P), nl,
    write('The Vice-President is '), write(VP), nl,
    write('The Secretary is '), write(S), nl,
    write('The Treasurer is '), write(T), nl.

% the ordering is similar to order of constraints and as soon as person is generated it is checked.
solve(L) :- L = [Pres, Vice, Secr, Treas],
    competitor(Pres), competitor(Vice), Vice \= bart,
    Vice \= arthur, 

    competitor(Secr), 
    Secr \= bart,    
 
    competitor(Treas), 
    worksonlywith(arthur,bart,L),

    distinct_people(L),
    crule(colleen,frank,bart,L),
    not(membersTogether(donna,eva,L)), not(membersTogether(donna,frank,L)),
    erule(eva,arthur,bart,L),
    frule(frank, colleen, Pres, Vice,L),
    distinct_people(L).



% Knowledge Base
competitor(arthur). competitor(bart). competitor(colleen). competitor(donna). competitor(eva). competitor(frank).

% check if list is full of unique members
distinct_people([]).
distinct_people([N|L]) :- distinct_people(L), not(member(N,L)).

% simply check if both members are in the list at the same time
membersTogether(A,B,L) :- member(A,L), member(B,L).

% check if either both members are in OR first member is not in and we don't care if second is in or not
% (if arthur is in he wants bart as well, else arthur is not in so we don't care about bart)
worksonlywith(A,B,L) :- member(A,L), member(B,L).
worksonlywith(A,_,L) :- not(member(A,L)).

% rule for colleen: either all 3 frank, bart and colleen are in OR bart is not in, then we don't care about frank and colleen is in
% OR colleen is not in then we just go with our day
crule(A,B,C,L):- member(A,L), member(B,L), member(C,L).
crule(A,B,_,L):- member(A,L), not(member(B,L)).
crule(A,_,_,L):- not(member(A,L)).

% rule for eva: first eva is not in if arthur and bart are in, then the opposite, then eva and bart are in without arthur and then eva+arthur without bart.
erule(A,B,C,L):- not(member(A,L)), member(B,L), member(C,L).
erule(A,B,C,L):- member(A,L), not(member(B,L)), not(member(C,L)).
erule(A,B,C,L):- member(A,L), member(B,L), not(member(C,L)).
erule(A,B,C,L):- member(A,L), not(member(B,L)), member(C,L).

% rule for frank, he wants to be Pres and colleen to not be his Vice
frule(A,B,C,D,L):- member(A,L), A=C, B\=D.