module("modules.configs.excel2json.lua_assist_boss_stance", package.seeall)

slot1 = {
	sceneId = 2,
	position = 3,
	scale = 4,
	skinId = 1
}
slot2 = {
	"skinId",
	"sceneId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
