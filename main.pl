
main(Rez) :- open('input.in',read,Stream), read(Stream,List), close(Stream), % reads from input.in. Must contain a list in the form "[v1,v2,v3,...,vn]."
    X =.. [arr|List], functor(X,arr,N), N1 is N//2, shellSort(X,N,N1,Rez).   % simply query with main(Rez) after creating the correct file.

shellSort(Rez,_,0,Rez).
shellSort(X,N,Space,Rez) :- Space > 0,  NextSpace is Space//2, shellSort(X,N,NextSpace,OldRez),
	splitEveryT(OldRez,Space,N,0,SplitX),
    insertionSort2(SplitX,RezSplit), splitEveryT(Rez,Space,N,0,RezSplit).
    

splitEveryT(X,T,N,I,[ [Val|T1]|T2]) :-  I =< N, I1 is I+1, functor(X,arr,N),
    arg(I1,X,Val),  NextI is I + T,splitEveryT(X,T,N,NextI,[T1|T2]).
splitEveryT(X,T,N,I,[ []|Rez]) :- I >= N, NextI is (I+1) mod T, NextI \= 0, splitEveryT(X,T,N,NextI,Rez).
splitEveryT(_,T,N,I,[[]]) :- I >= N, 0 is (I+1) mod T.
    
insertionSort2([], []).
insertionSort2([H|T], [RezH|Rez]) :- is_list(H), insertionSort(H,RezH), insertionSort2(T,Rez).

insertionSort([],[]).
insertionSort([H|T],Rez) :- insertionSort(T,R1), insert(R1,H,Rez).
insert([],Val,[Val]).
insert([H|T],Val,[H|Rez]) :- Val>H, insert(T,Val,Rez).
insert([H|T],Val,[Val,H|T]) :- Val =< H.
