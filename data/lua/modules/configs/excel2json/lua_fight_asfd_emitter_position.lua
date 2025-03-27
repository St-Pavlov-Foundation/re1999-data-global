module("modules.configs.excel2json.lua_fight_asfd_emitter_position", package.seeall)

slot1 = {
	mySidePos = 2,
	enemySidePos = 3,
	sceneId = 1
}
slot2 = {
	"sceneId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
