module("modules.configs.excel2json.lua_fight_timeline_speed", package.seeall)

slot1 = {
	speed = 2,
	timeline = 1
}
slot2 = {
	"timeline"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
