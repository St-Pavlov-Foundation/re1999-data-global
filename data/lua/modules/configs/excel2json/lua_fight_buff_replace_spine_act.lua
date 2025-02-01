module("modules.configs.excel2json.lua_fight_buff_replace_spine_act", package.seeall)

slot1 = {
	combination = 4,
	priority = 3,
	buffId = 2,
	id = 1,
	suffix = 5
}
slot2 = {
	"id",
	"buffId",
	"priority"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
