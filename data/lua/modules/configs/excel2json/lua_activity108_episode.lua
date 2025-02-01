module("modules.configs.excel2json.lua_activity108_episode", package.seeall)

slot1 = {
	period = 5,
	mapId = 2,
	actpoint = 6,
	epilogue = 8,
	day = 4,
	showBoss = 10,
	res = 3,
	id = 1,
	showExhibits = 9,
	preface = 7
}
slot2 = {
	"id"
}
slot3 = {
	epilogue = 2,
	preface = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
