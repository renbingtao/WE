
jass_code=[[
function japi_plugin_DoNothing takes nothing returns nothing

endfunction
function japi_plugin_init_action takes nothing returns nothing
	call ExecuteFunc("japi_plugin_init_variable")
	call ExecuteFunc("japi_plugin_DoNothing")
	call StartMeleeAI(Player(12), "callback" )
endfunction

]]

jass_main=[[

function main takes nothing returns nothing
	call japi_plugin_init_action()
	call AbilityId("exec-lua:jass2lua.runtime")
	call AbilityId("exec-lua:jass2lua.main")
endfunction

]]

jass_globals={"globals\n"}
jass_variable_init_code={"function japi_plugin_init_variable takes nothing returns nothing\n"}
for i=1,32 do
	table.insert(jass_globals,"integer array i_"..i.."\n")
	table.insert(jass_variable_init_code,"set i_"..i.."[8191]=0\n")
end
table.insert(jass_globals,"endglobals\n")
table.insert(jass_variable_init_code,"endfunction\n")
jass_code=table.concat(jass_globals)..table.concat(jass_variable_init_code)..jass_code



function conver(str)

	func_table={
		'InitCustomPlayerSlots',
		'InitCustomTeams',
		'InitAllyPriorities',
		'config',

	}
	func={}
    for i=1,#func_table do
        str=str:gsub('(function '..func_table[i]..' takes nothing returns nothing)(.-)(endfunction)',
            function (head,code,ending)
                table.insert(func,table.concat({head,code,ending,'\n'}))
                return ''
            end)
    end
	return jass_code..table.concat(func):gsub('function config',
        function ()
            return jass_main..'\nfunction config'
        end),str
end




