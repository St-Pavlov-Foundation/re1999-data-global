module("modules.configs.excel2json.lua_character_motion_cut", package.seeall)

slot1 = {
	onlyStopCut = 4,
	heroId = 1,
	motion = 3,
	skinId = 2
}
slot2 = {
	"heroId",
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
