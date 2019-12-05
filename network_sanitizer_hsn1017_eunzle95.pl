%to be completed
			      

isProblematic(S) :-
                  sub_string(S, _, _, _, 'bong');
                  sub_string(S, _, _, _, 'wasted');
                  sub_string(S, _, _, _, 'snorted');
                  sub_string(S, _, _, _, 'drinking').

% the final rule to build
% toBeCheckedPost(User, IntViewer, ID) :- ...

toBeCheckedPost(User, IntViewer, ID) :-
    checkFriends(User,IntViewer, []),
    numFriends(Friends,User),
    post(ID,_,Msg),
    (countLiked(Liked,ID),
    isProblematic(Msg),
    Liked > Friends * 0.2);
    (numFriends(Friends,User),
    countComment(Comment,ID),
    Comment > Friends * 0.3).

not_friend(_, []).
not_friend(X, [H|T]) :- dif(X, H), not_friend(X, T).

checkFriends(A,B, Seen) :- not_friend(B, Seen), mutual(A, B).
checkFriends(A,B, Seen) :- mutual(A, X), not_friend(X, Seen), checkFriends(X, B, [A|Seen]).

mutual(A, B) :- friended(A, B); friended(B, A).

numFriends(Total,A):- 
    findall(_,mutual(A,_),Ns),
    length(Ns,Total).

countLiked(Total,P):-
    findall(P,like(_,P),Ns),
    length(Ns,Total).

countComment(Total,P):-
    post(P, _, _),
    findall(P,comment(_,P,_),Ns),
    length(Ns,Total).



%setof(ID, toBeCheckedPost(joe, rick, ID), S).
