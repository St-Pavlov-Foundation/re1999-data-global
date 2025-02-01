module("modules.configs.excel2json.lua_character_limited", package.seeall)

slot1 = {
	entranceEffect = 8,
	spineParam = 3,
	mvtime = 5,
	spine = 2,
	actionTime = 7,
	entranceMv = 4,
	effectDuration = 9,
	voice = 6,
	audio = 10,
	stopAudio = 11,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
