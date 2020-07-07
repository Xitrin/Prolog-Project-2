

result(-1). result(0). result(1). result(2).


toronto2(A,B):- A=2,B=0.
toronto2(A,B):- A=0,B=2.
oak3(A,B,C):- A=2,B=2,C\=2.
oak3(A,B,C):- A=2,B\=2,C=2.
oak3(A,B,C):- A\=2,B=2,C=2.

count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

fourExactly(X, List):- count(List, X, 4).

rh5(X,Y,0):-count(0, X, 1), count(0, Y, 1).

none(X, 0):- count(0, X, 0).
one(X, 0):- count(0, X, 1).


evenwins(X, Y, 0):- count(0,X,0), count(0,Y,0).
evenwins(X, Y, 0):- count(0,X,1), count(0,Y,1).
evenwins(X, Y, 0):- count(0,X,2), count(0,Y,2).


solve([L1, L2, L3, L4, L5]) :- L1 = [O1,P1,R1,S1,T1], 
    L2 = [O2,P2,R2,S2,T2], 
    L3 = [O3,P3,R3,S3,T3], 
    L4 = [O4,P4,R4,S4,T4], 
	L5 = [O5,P5,R5,S5,T5], 
    
     
    result(S1), S1 = 2, result(P1), P1 = 0, result(P2), P2 = 2, 
    result(T3), T3 = -1, 
    result(T1), result(T2), toronto2(T1,T2),
    result(O4), O4 = -1, result(O2), O2 = 0, result(O1), result(O3), oak3(O1,O2,O3), 
    result(S4), result(R4), result(T4), result(P4), fourExactly(1, L4), 
    result(O5), result(P5), result(R5), result(S5), result(T5), fourExactly(1, L5),
    result(R1), result(R2), result(R3), rh5(2, 0, [R1, R2, R3]), 
    none(1, L1), result(S2), none(1, L2), result(P3), result(S3), none(1, L3),
one(-1, L1),  one(-1, L2),     one(-1, L3),     one(-1, L4),     one(-1, L5),
one(-1, [O1,O2,O3,O4,O5]),
one(-1, [P1,P2,P3,P4,P5]),
one(-1, [R1,R2,R3,R4,R5]),
one(-1, [S1,S2,S3,S4,S5]),
one(-1, [T1,T2,T3,T4,T5]),
evenwins(2, 0, L1),
evenwins(2, 0, L2),
evenwins(2, 0, L3),
evenwins(2, 0, L4),
evenwins(2, 0, L5).
    