module("modules.configs.excel2json.lua_fight_music", package.seeall)

slot1 = {
	param = 5,
	battleId = 2,
	monster = 3,
	switch = 6,
	id = 1,
	invokeType = 4
}
slot2 = {
	"id",
	"battleId",
	"monster",
	"invokeType",
	"param"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
