top(heap(V, _), V).

meld(nil, H, H) :- !.
meld(H, nil, H) :- !.
meld(H1, H2, G) :-
	H1 = heap(V1, S1),
	H2 = heap(V2, S2),
	( V1 @< V2
			-> G = heap(V1, [H2|S1])
			;  G = heap(V2, [H1|S2])
	).

merge([], nil).
merge([H], H) :- !.
merge([H1,H2|Hs], H) :-
	meld(H1, H2, Hm),
	merge(Hs, Hr),
	meld(Hm, Hr, H).

insert(H, K, G) :-
	meld(H, heap(K, []), G).

remove(H, G) :-
	H = heap(_, S),
	merge(S, G).

process(_, end_of_file, _) :- !.
process(H, [0, X]) :-
	insert(H, X, G),
	readln(Y),
	process(G, Y).

process(H, [1]) :-
	top(H, T),
	writeln(T),
	readln(Y),
	process(H, Y).

process(H, [2]) :-
	remove(H, G),
	readln(Y),
	process(G, Y).

main :-
	readln(X),
	process(nil, X),
	halt.
