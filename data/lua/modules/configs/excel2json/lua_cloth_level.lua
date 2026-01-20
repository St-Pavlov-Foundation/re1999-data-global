-- chunkname: @modules/configs/excel2json/lua_cloth_level.lua

module("modules.configs.excel2json.lua_cloth_level", package.seeall)

local lua_cloth_level = {}
local fields = {
	usePower1 = 14,
	passiveSkills = 12,
	usePower3 = 22,
	id = 1,
	death = 10,
	recover = 7,
	compose = 6,
	move = 5,
	skill2 = 17,
	maxPower = 3,
	cd2 = 19,
	desc = 11,
	allLimit3 = 24,
	defeat = 9,
	use = 4,
	level = 2,
	allLimit1 = 16,
	allLimit2 = 20,
	exp = 25,
	skill3 = 21,
	usePower2 = 18,
	skill1 = 13,
	cd3 = 23,
	initial = 8,
	cd1 = 15
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	desc = 1
}

function lua_cloth_level.onLoad(json)
	lua_cloth_level.configList, lua_cloth_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_cloth_level
