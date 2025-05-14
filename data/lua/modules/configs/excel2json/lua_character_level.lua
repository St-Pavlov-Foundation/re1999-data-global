module("modules.configs.excel2json.lua_character_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cri_def = 11,
	def = 5,
	technic = 7,
	cri = 8,
	cri_dmg = 10,
	recri = 9,
	mdef = 6,
	drop_dmg = 13,
	add_dmg = 12,
	heroId = 1,
	hp = 3,
	atk = 4,
	level = 2
}
local var_0_2 = {
	"heroId",
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
