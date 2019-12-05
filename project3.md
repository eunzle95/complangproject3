Project3 README
===
written by Sam Heo and Eunoh Cho
---

Specification about the project3
>What was done for this project
    For this project we learned Prolog language throughly to parse through functions and gather information to get what we would like to do. Simply it was parsing data of personal information in Social Network Systems through using Prolog code to get the data that are inappropriate.
>Explanation of the code
    We have implemented function called toBeCheckedPost(_,_,_).
```
checkFriends(User,IntViewer, []),
```
    First thing we checked is if the interviewee(second parameter of the function) and the user(first parameter) are friends or friends of friends. 
    ```
        numFriends(Friends,User),
        post(ID,_,Msg),
    ```
    After checknig the connection between two, we check the number of friends of the user and get the post messages that the user posted on Social Network System.

    ```
        (countLiked(Liked,ID),
        isProblematic(Msg),
        Liked > Friends * 0.2);
    ```
    This is where it goes to if-else case using ';'.
    The first case is if the number of likes on certain post exceeds 20% of the number of the user's friends and if the user's post contains any inapporipriate wordings.
    ```
        (numFriends(Friends,User),
        countComment(Comment,ID),
        Comment > Friends * 0.3).
    ```
    This is the else case where it checkes if the number of comments exceeds 30% of the number of the user's friends. 

    By using this toBeCheckedPost function users can know post IDs that is inappropriate.

    ```
        not_friend(_, []).
        not_friend(X, [H|T]) :- dif(X, H), not_friend(X, T).
    ```
    This code is a helper method to check if the user is friend with other user.

    ```
        checkFriends(A,B, Seen) :- not_friend(B, Seen), mutual(A, B).
        checkFriends(A,B, Seen) :- mutual(A, X), not_friend(X, Seen), checkFriends(X, B, [A|Seen]).
    ```
    This code is checking if A is friend with B or friends of friends.

    ```
        mutual(A, B) :- friended(A, B); friended(B, A).
    ```
    This is a helper function to check is A is friend with B or the other way around.
    ```
        numFriends(Total,A):- 
        findall(_,mutual(A,_),Ns),
        length(Ns,Total).
    ```
    This helper function stores number of A's friends in Total.

    ```
        countLiked(Total,P):-
        findall(P,like(_,P),Ns),
        length(Ns,Total).
    ```
    This helper functions stores number of likes on specific post called P.

    ```
        countComment(Total,P):-
        post(P, _, _),
        findall(P,comment(_,P,_),Ns),
        length(Ns,Total).
    ```
    This helper functions stores number of comments on specific post called P.