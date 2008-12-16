-module(entry).
-export([relations/0 , use_fields/0]).
    
relations() ->
	[{one_to_many, [comment]}],
    [{many_to_one, [category]}].

use_fields() ->
	[title, body, category].