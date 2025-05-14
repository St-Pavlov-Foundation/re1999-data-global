module("modules.configs.excel2json.lua_fight_music", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 5,
	battleId = 2,
	monster = 3,
	switch = 6,
	id = 1,
	invokeType = 4
}
local var_0_2 = {
	"id",
	"battleId",
	"monster",
	"invokeType",
	"param"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
