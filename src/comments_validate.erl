-module(comments_validate).
-export([name/1, email/1, comment/1 , entry_id/1]).
-define(EMAILREG, "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*$").


name(undefined) ->
	{error, name, "The name field is blank."};
name(_) ->
 	ok.

email(undefined) ->
	{error, email, "The email field is blank."};
email(Email) ->
	case regexp:match(Email, ?EMAILREG) of
		{match, _, Length} when length(Email) == Length ->
			Value = ok;
		_ ->
			Value = {error, email , "invalid email address"}
	end,
	Value.


comment(undefined) ->
	{error, comment, "The comment field is blank."};
comment(_) ->
	ok.
	

entry_id(undefined) ->
	{error, comment, "entry id can't be blank"};
entry_id(Id) ->
	Entry = entry:find_id(Id),
	case Entry of
		undefined ->
			Value = {error, comment, "entry id can't be blank"};
		_ ->
			Value = ok
	end,
	Value.