-module(hausaufgabe1).
-export([minimum_of_list/1, minimum_of_list/2, maximum_of_list/1, maximum_of_list/2, reverse/1, find/2, delete/2, flatten/1, 
square1/1, square2/1, square3/1, filter1/2, filter2/2, filter3/2, avg_server1/1]).

% Minimum in a list.
minimum_of_list([]   ) -> empty;
minimum_of_list([First|Rest]) -> {ok, minimum_of_list(First, Rest)}.

minimum_of_list(First, []) -> First;
minimum_of_list(First, [Second|Rest]) when First > Second -> minimum_of_list(Second, Rest);
minimum_of_list(First, [_|Rest]) -> minimum_of_list(First, Rest).

% Maximum in a list.
maximum_of_list([]) -> empty;
maximum_of_list([First|Rest]) -> {ok, maximum_of_list(First, Rest)}.

maximum_of_list(First, []) -> First;
maximum_of_list(First, [Second|Rest]) when First < Second -> maximum_of_list(Second, Rest);
maximum_of_list(First, [_|Rest]) -> maximum_of_list(First, Rest).
% General syntax

% Implement reverse
reverse([]) -> [];
reverse([X|Xs]) -> reverse(Xs) ++ [X].

% Implement a function that finds and returns an element in a list
find(_, []) -> not_found;
find(X, [X|_]) -> {found, X};
find(X, [_|Ys]) -> find(X, Ys).

% Implement a functions that deletes the first occurence of an element from a list
delete(_, []) -> [];
delete(X, [X|Ys]) -> Ys;
delete(X, [Y|Ys]) -> [Y|delete(X, Ys)].

% Implement flatten using append (flatten exists as lists:flatten/1)
flatten([]) -> [];
flatten([Xs|Ys]) -> Xs ++ flatten(Ys).

% Implement a function which squares every number in a list. Do this first using tail recursion, 
% then using a list comprehension, then using lists:map/2
square1([]) -> [];
square1([X|Xs]) -> [X*X | square1(Xs)].

square2(Xs) -> [X*X || X <- Xs].

square3(Xs) -> lists:map(fun(X) -> X*X end, Xs).

% Implement filter: given a predicate (Boolean function) and a list, return the sublist containing only elements for which the predicate holds.
filter1(_, []) -> [];
filter1(F, [X|Xs]) ->
  case F(X) of
    true -> [X|filter1(F, Xs)] ;
    false -> filter1(F, Xs)
  end.

filter2(_, []) -> [];
filter2(F, [X|Xs]) ->
  Result = F(X),
  if
    Result -> [X|filter2(F, Xs)] ;
    true   -> filter2(F, Xs)
  end.

filter3(F, Xs) -> [X || X <- Xs, F(X)].

% Simple message passing
avg_server1(Avg) ->
  io:fwrite("Current average is ~p~n", [Avg]),
  receive
    Num -> avg_server1((Avg + Num) / 2)
  end.
  

