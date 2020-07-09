print_solution(L):- L = [G,E,T,B,Y,A,R],  solve(L),
		write('   '), write(G), write(E), write(T), nl,
		write('*'), write('   '),  write(B),write(Y),nl,
		write('-------'),nl,
		write('  '), write(B), write(A), write(B), write(E), nl,
		write('+'), write(' '), write(G), write(E), write(T), write(' '), nl,
		write('-------'),nl,
		write(' '), write(B), write(E), write(A), write(R), write(E), nl.


% In interleaving generate and test as soon as number is chosen for variable this number is tested against crypto rules.
% In similar way when number is supposed to be checked again it is done as soon as all the variables for the check are already introduced to decrease backtracking.
% The order for variables is mostly because of using already generated numbers and how the calculation would go by hand.
solve([G,E,T,B,Y,A,R]) :- 
	
	% to get E and C1(first carry) we only need Y and T so we generate only these first.
	dig(E), dig(Y), dig(T), 
	E is (Y*T) mod 10, C1 is (Y*T) // 10,
	
	% to get B and C2 we need existing Y and E no need generating them again.
	% for T and C3 we need existing B and pre-generated T
	% E is checked using existing numbers.
	dig(B), B > 0, 
	B is (Y*E + C1) mod 10, C2 is (Y*E + C1) // 10,
	T is (B*T) mod 10, C3 is (B*T) // 10,
	E =:= (B*E + C3) mod 10, C4 is (B*E + C3) // 10,
	
	% R is calculated using existing numbers so it is next.
	dig(R),
	R is (B + T) mod 10, C5 is (B + T) // 10,
	
	% similar reasoning as R.
	dig(G), G > 0,
	G is (B*G + C4) mod 10, (B*G + C4) // 10 =:= 0,
	
	% A is last but we only need it to check.
	dig(A), 
	A =:= (A + E + C5) mod 10, C6 is (A + E + C5) // 10,
	E =:= (B + G + C6) mod 10, B =:= (B + G + C6) // 10,
	A is (Y*G + C2) mod 10, B =:= (Y*G + C2) // 10,
	
	
	all_diff([G,E,T,B,Y,A]).


% Knowledge Base

dig(0). dig(1). dig(2). dig(3). dig(4). dig(5). dig(6). dig(7). dig(8). dig(9). 
all_diff([]).
all_diff([N|L]) :- not(member(N,L)), all_diff(L).
