-module(entry_controller).
-export([index/1, entry/2, detail/2 , new/1 , new_get/0 , new_post/1 , new_comment/1]).

index(A) ->
    Entries = entry:find_with({order_by, [{id, desc}]}),
    [{ewc, entry, entry, [A, Entry]} || Entry <- Entries].

entry(A, Entry) ->
    Category = entry:category(Entry),
 	%% @TODO
    %% i can't get the count to work for some stupid reason, ignore and fix later
	%%Comments_count =  comment:count({entry_id,'=', entry:id(Entry) }), 
	 Comments = comment:find({entry_id,'=', integer_to_list(entry:id(Entry))  }),
	{data, 
        {integer_to_list(entry:id(Entry)),
         entry:title(Entry),
         helpers:setup_entry_body_with_textmate(Entry),
         helpers:setup_date_from_mysql_val(entry:created_on(Entry)),
		 integer_to_list(category:id(Category)),
         category:title(Category),
     	 integer_to_list(lists:flatlength(Comments))
		}
	}.     

detail(A, Id) ->
    Entry = entry:find_id(Id),
    Category = entry:category(Entry),
    Comments = comment:find({entry_id,'=', integer_to_list(entry:id(Entry))  }),
	{data, 
        {integer_to_list(entry:id(Entry)),
		 entry:title(Entry),
         helpers:setup_entry_body_with_textmate(Entry),
         helpers:setup_date_from_mysql_val(entry:created_on(Entry)),
		 integer_to_list(category:id(Category)),
         category:title(Category),
		 integer_to_list(lists:flatlength(Comments)),
		 Comments
		}
    }.


new(A) ->
	Categories = category:find_with({order_by, [{id, desc}]}),
	case yaws_arg:method(A) of
	'GET' ->
	  	{data, {Categories,[], new_get()}};
	'POST' ->
	  	Vals = yaws_api:parse_post(A),
	  	{Errors, Entry} = new_post(Vals),
	  	case Errors of
	   	ok ->
			{ewr, entry};
	   	_ ->
	    	{data, { Categories , Errors, Entry}}
	  	end
	end.
	
new_get() ->
	   Entry = entry:new(),
	   Entry.

new_post(Vals) ->
	Entry = entry:set_fields_from_strs(entry:new(), Vals),
	Errors = helpers:validate(entries_validate, entry, Entry),
	case Errors of
	 ok ->
	  entry:save(Entry),
	  {ok, Entry};
	 _ ->
	  {Errors, Entry}
	end.
	
	
new_comment(A) ->
	Vals = yaws_api:parse_post(A),
	Comment = comment:set_fields_from_strs(comment:new(), Vals),
	Entry = comment:entry(Comment),
	Errors = helpers:validate(comments_validate, comment, Comment),
	case Errors of
	 ok ->
	  comment:save(Comment),
	  {ewr,entry ,detail , [entry:id(Entry)]  };
	 _ ->
	  {ewr, entry, detail, [entry:id(Entry)]}
	end.