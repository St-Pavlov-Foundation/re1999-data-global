module("modules.configs.excel2json.lua_fight_skin_replace_magic_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	closeEffect = 7,
	enterTime = 4,
	skinId = 2,
	closeTime = 8,
	enterEffect = 3,
	enterAudio = 5,
	posArr = 11,
	loopEffect = 6,
	id = 1,
	closeAudio = 10,
	closeAniName = 9
}
local var_0_2 = {
	"id",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
