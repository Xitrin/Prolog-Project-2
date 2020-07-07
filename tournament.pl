% Farkhad Gapparov 500718721, Sec 052
% Mohib Abdullah 500715782

% different ordering of matches oriented to teams, not rounds like before.
% using scoring letters -> numbers (.ex w = 2). Calculating total for each team
% (skipped match counts as -1, so total is lower than if it counted as 0, to change it change scoring of n in solve(L))
% and final table.

print_solution :-
	solve([L1, L2, L3, L4, L5]),
	L1 = [O1,P1,R1,S1,T1], 
	L2 = [O2,P2,R2,S2,T2], 
	L3 = [O3,P3,R3,S3,T3], 
	L4 = [O4,P4,R4,S4,T4], 
	L5 = [O5,P5,R5,S5,T5], 	

	scoring(O1,SO1),scoring(O2,SO2),scoring(O3,SO3),scoring(O4,SO4), scoring(O5,SO5),
	O = [SO1,SO2,SO3,SO4, SO5], 

	scoring(P1,SP1),scoring(P2,SP2),scoring(P3,SP3),scoring(P4,SP4), scoring(P5,SP5),
	P = [SP1,SP2,SP3,SP4, SP5], 

	scoring(R1,SR1),scoring(R2,SR2),scoring(R3,SR3),scoring(R4,SR4), scoring(R5,SR5),
	R = [SR1,SR2,SR3,SR4, SR5], 

	scoring(S1,SS1),scoring(S2,SS2),scoring(S3,SS3),scoring(S4,SS4), scoring(S5,SS5),
	S = [SS1,SS2,SS3,SS4, SS5], 

	scoring(T1,ST1),scoring(T2,ST2),scoring(T3,ST3),scoring(T4,ST4), scoring(T5,ST5),
	T = [ST1,ST2,ST3,ST4, ST5], 

	OT is SO1+SO2+SO3+SO4+SO5,
	PT is SP1+SP2+SP3+SP4+SP5,
	RT is SR1+SR2+SR3+SR4+SR5,
	ST is SS1+SS2+SS3+SS4+SS5,
	TT is ST1+ST2+ST3+ST4+ST5,
	
	write('              R1 R2 R3 R4 R5 Total'), nl,
	write('Oakville      '), write(O), write(OT), nl,
	write('Pickering     '), write(P), write(PT), nl,
	write('Richmond Hill '), write(R), write(RT), nl,
	write('Scarborough   '), write(S), write(ST), nl,
	write('Toronto       '), write(T), write(TT), nl.


% solve, it does not output numbered results and simply shows results for each round in a list. 
% Order for teams in each round is : Oakville, Pickering, Richmond Hill, Scarborough, Toronto.

solve([L1, L2, L3, L4, L5]) :- 

	L1 = [O1,P1,R1,S1,T1], 
	L2 = [O2,P2,R2,S2,T2], 
	L3 = [O3,P3,R3,S3,T3], 
	L4 = [O4,P4,R4,S4,T4], 
	L5 = [O5,P5,R5,S5,T5], 

	% the order is pretty much the same as order of given constraints, the generate part is moved as close as possible to the closest checking rule.
	result(S1), S1 = w, result(P1), P1 = l,
	result(P2), P2 = w, result(T3), T3 = n, 
	result(T1), result(T2), toronto2(T1,T2),
	result(O4), O4 = n, 
	result(O2), O2 = l, 
	result(O1), result(O3), oak3(O1,O2,O3), 
	result(S4), result(R4), result(T4), result(P4), fourExactly(d, L4), 
	result(O5), result(P5), result(R5), result(S5), result(T5), fourExactly(d, L5),
	result(R1), result(R2), result(R3), rh5(w, l, [R1, R2, R3]), 
	none(d, L1), result(S2), none(d, L2), result(P3), result(S3), none(d, L3),
	
	% check that team can only have one skipped match over 5 rounds.
	one(n, L1), one(n, L2), one(n, L3), one(n, L4), one(n, L5),
	one(n, [O1,O2,O3,O4,O5]),
	one(n, [P1,P2,P3,P4,P5]),
	one(n, [R1,R2,R3,R4,R5]),
	one(n, [S1,S2,S3,S4,S5]),
	one(n, [T1,T2,T3,T4,T5]),
	
	% check that each team has (number of wins) = (number of losses)
	evenwins(w, l, L1),
	evenwins(w, l, L2),
	evenwins(w, l, L3),
	evenwins(w, l, L4),
	evenwins(w, l, L5).

	% changes letters to numbers
	scoring(X, Y):- X = w, Y = 2.
	scoring(X, Y):- X = l, Y = 0.
	scoring(X, Y):- X = d, Y = 1.
	scoring(X, Y):- X = n, Y = -1.



% Knowledge Base

result(n). result(l). result(d). result(w).

% toronto or 2nd constraint check.
toronto2(A,B):- A=w,B=l.
toronto2(A,B):- A=l,B=w.

% oakville or 3rd constraint check. 
oak3(A,B,C):- A=w,B=w,C\=w.
oak3(A,B,C):- A=w,B\=w,C=w.
oak3(A,B,C):- A\=w,B=w,C=w.

% this simply counts whatever you are looking for in given list.
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

% as explained in assignment, true if 4 of same are in the list.
fourExactly(X, List):- count(List, X, 4).

% richmond hill or 3rd constraint. counts for 1 loss and 1 win in last 3 rounds.(1-3)
rh5(X,Y,L):-count(L, X, 1), count(L, Y, 1).

% makes sure apperance of X is 0 times in given list
none(X, L):- count(L, X, 0).

% same as none but 1 time.
one(X, L):- count(L, X, 1).

evenwins(X, Y, L):- count(L,X,0), count(L,Y,0).
evenwins(X, Y, L):- count(L,X,1), count(L,Y,1).
evenwins(X, Y, L):- count(L,X,2), count(L,Y,2).