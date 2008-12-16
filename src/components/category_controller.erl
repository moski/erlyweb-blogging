-module(category_controller).
-export([detail/2, entry/2]).

detail(A, Id) ->
    Category = category:find_id(Id),
    [{data, 
        {category:title(Category),
         category:description(Category)}},
     [{ewc, category, entry, [A, Entry]} || Entry <- category:entries(Category)]
    ].

entry(A, Entry) ->
    {data, 
        {integer_to_list(entry:id(Entry)),
         entry:title(Entry),
         entry:body(Entry)}
    }.

