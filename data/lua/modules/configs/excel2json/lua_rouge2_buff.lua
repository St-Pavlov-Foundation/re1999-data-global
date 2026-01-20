-- chunkname: @modules/configs/excel2json/lua_rouge2_buff.lua

module("modules.configs.excel2json.lua_rouge2_buff", package.seeall)

local lua_rouge2_buff = {}
local fields = {
	unlock = 15,
	name = 2,
	isOff = 3,
	outUnlock = 5,
	isHide = 7,
	career = 14,
	desc = 16,
	updateId = 18,
	descSimply = 17,
	passiveSkillId = 8,
	tag = 10,
	icon = 11,
	attributeTag = 13,
	sortId = 4,
	outUnlockDesc = 6,
	system = 20,
	descUpdate = 19,
	rare = 9,
	id = 1,
	attribute = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	descSimply = 4,
	outUnlockDesc = 2,
	descUpdate = 5,
	desc = 3
}

function lua_rouge2_buff.onLoad(json)
	lua_rouge2_buff.configList, lua_rouge2_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_buff
