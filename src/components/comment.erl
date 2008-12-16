-module(comment).
-export([relations/0 , use_fields/0]).
    
relations() ->
	[{many_to_one, [entry]}].

use_fields() ->
	[name, email, comment , entry_id].