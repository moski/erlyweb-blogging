-module(textmate).
-export([job/1]).

%% How to Run:
%% Str1  = "my code"
%% Str2 = list_to_binary(Str1).  %% convert the string into binary string..  
%% textmate:job({textmate, Str2})

job(Info) ->
	Cmd = lists:append(["ruby " , helpers:do_op() , "/src/textmate.rb"]),
	Port = open_port({spawn, Cmd}, [{packet, 4}, use_stdio, exit_status, binary]),

	case Info of
		{echo, String} ->
			Payload = term_to_binary({echo, String}),
			port_command(Port, Payload);	
		{textmate, String} ->
			Payload = term_to_binary({textmate, String}),
			port_command(Port, Payload);
		Error ->
			Error
	end,

	receive
	{Port, {data, Data}} ->
		{result, Text} = binary_to_term(Data)	
end,
Text.