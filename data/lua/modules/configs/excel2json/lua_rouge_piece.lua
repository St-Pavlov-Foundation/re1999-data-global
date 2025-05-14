module("modules.configs.excel2json.lua_rouge_piece", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	version = 2,
	title = 5,
	talkId = 7,
	pieceRes = 4,
	id = 1,
	entrustType = 3,
	bossEffect = 8,
	desc = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
