module("modules.configs.excel2json.lua_rouge_piece_position", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	layerId = 3,
	unlockParam = 5,
	version = 2,
	pieceRes = 8,
	talkId = 11,
	entrustType = 7,
	title = 9,
	desc = 10,
	unlockType = 4,
	talkView = 12,
	id = 1,
	icon = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
