module("modules.configs.excel2json.lua_fight_replace_timeline", package.seeall)

slot1 = {
	condition = 6,
	priority = 3,
	timeline = 2,
	id = 1,
	target = 4,
	simulate = 5
}
slot2 = {
	"id",
	"timeline"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
