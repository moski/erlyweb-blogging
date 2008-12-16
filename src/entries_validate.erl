-module(entries_validate).
-export([title/1, body/1, category/1]).

title(undefined) ->
	{error, title, "The title field is blank."};
title(_) ->
 	ok.

body(undefined) ->
	{error, body, "The body field is blank."};
body(_) ->
	ok.

category(undefined) ->
	{error, category, "The category field is blank."};
category(_) ->
	ok.