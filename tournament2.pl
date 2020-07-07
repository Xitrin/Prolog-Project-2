
%teams(o). teams(p). teams(r). teams(s). teams(t).

result(n). result(l). result(d). result(w).

%score([L]) :- member(L, [-1,0,1,2])
%team_score([L]):- 

toronto2(A,B):- A=w,B=l.
toronto2(A,B):- A=l,B=w.
oak3(A,B,C):- A=w,B=w,C\=w.
oak3(A,B,C):- A=w,B\=w,C=w.
oak3(A,B,C):- A\=w,B=w,C=w.

count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

fourExactly(X, List):- count(List, X, 4).

rh5(X,Y,L):-count(L, X, 1), count(L, Y, 1).

none(X, L):- count(L, X, 0).


solve([L1, L2, L3, L4, L5]) :- L1 = [O1,P1,R1,S1,T1], 
    L2 = [O2,P2,R2,S2,T2], 
    L3 = [O3,P3,R3,S3,T3], 
    L4 = [O4,P4,R4,S4,T4], 
	L5 = [O5,P5,R5,S5,T5], 
    
     
    result(S1), S1 = w, result(P1), P1 = l, result(P2), P2 = w, 
    result(T3), T3 = n, 
    result(T1), result(T2), toronto2(T1,T2),
    result(O4), O4 = n, result(O2), O2 = l, result(O1), result(O3), oak3(O1,O2,O3), 
    result(S4), result(R4), result(T4), result(P4), fourExactly(d, L4), 
    result(O5), result(P5), result(R5), result(S5), result(T5), fourExactly(d, L5),
    result(R1), result(R2), result(R3), rh5(w, l, [R1, R2, R3]), 
    none(d, L1), result(S2), none(d, L2), result(P3), result(S3), none(d, L3).
    
    