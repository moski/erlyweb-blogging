-module(category).
-export([relations/0]).
    
relations() ->
    [{one_to_many, [entry]}].