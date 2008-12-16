-module(helpers).
-export([value/1, validate/3  , setup_date_from_mysql_val/1 , do_op/0 , setup_msg_for_display/1 , setup_entry_body_with_textmate/1]).

value(Val) ->
	case Val of
 		undefined ->
  			"";
 		_ ->
  			Val
	end.

validate(ValidatorModule, Model, Item) ->
	Fields = Model:use_fields(),
	Results = [ValidatorModule:Field(Model:Field(Item)) || Field <- Fields],  
	Errors = [Error || Error <- Results,element(1, Error) == error],    
	case Errors of   
		[] ->
  			ok;
 		_ ->
     		Errors
	end.
	
setup_date_from_mysql_val(Date_tuple) ->
	 {_,TimeObj} = Date_tuple,
	 httpd_util:rfc1123_date(TimeObj).
	
	
do_op() ->
	{ok,Dir} = file:get_cwd(),
	Dir.


setup_entry_body_with_textmate(Entry) ->
	Client = memcached_client:new([{'127.0.0.1',11211}]),
	Key = lists:append([integer_to_list(entry:id(Entry)) , "-description"]),
	Results = memcached_client:get(Client , [list_to_binary(Key)]),
	case  Results of
		{_,[]} ->
			Value = setup_msg_for_display(entry:body(Entry)),
			memcached_client:set(Client , list_to_binary(Key), Value , 60*60*24*100);
		{ok,[{_,Val}]} ->
			Value = Val
	end,		
	Value.	

		
setup_msg_for_display(Str1) ->
	%%Str2 = list_to_binary(Str1),
	textmate:job({textmate, Str1}).