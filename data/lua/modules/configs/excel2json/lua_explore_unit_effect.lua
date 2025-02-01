module("modules.configs.excel2json.lua_explore_unit_effect", package.seeall)

slot1 = {
	prefabPath = 1,
	isLoopAudio = 7,
	audioId = 5,
	isBindGo = 6,
	animName = 2,
	effectPath = 3,
	isOnce = 4
}
slot2 = {
	"prefabPath",
	"animName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
