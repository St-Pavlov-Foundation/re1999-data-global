-- chunkname: @modules/configs/excel2json/lua_magic_circle.lua

module("modules.configs.excel2json.lua_magic_circle", package.seeall)

local lua_magic_circle = {}
local fields = {
	consumeNum = 7,
	enterTime = 16,
	selfSkills = 10,
	closeTime = 20,
	enemySkills = 11,
	enterAudio = 17,
	endSkills = 14,
	desc = 3,
	name = 2,
	consumeType = 6,
	selfAttrs = 8,
	closeAudio = 22,
	enemyBuff = 13,
	enemyAttrs = 9,
	selfBuff = 12,
	closeEffect = 19,
	enterEffect = 15,
	posArr = 23,
	round = 5,
	loopEffect = 18,
	id = 1,
	uiType = 4,
	closeAniName = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_magic_circle.onLoad(json)
	lua_magic_circle.configList, lua_magic_circle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_magic_circle
