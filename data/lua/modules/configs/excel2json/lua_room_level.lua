module("modules.configs.excel2json.lua_room_level", package.seeall)

slot1 = {
	cost = 2,
	needBlockCount = 3,
	characterLimit = 5,
	needCost = 6,
	maxBlockCount = 4,
	needEpisode = 7,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
