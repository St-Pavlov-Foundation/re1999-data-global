module("modules.configs.excel2json.lua_guide", package.seeall)

slot1 = {
	id = 1,
	priority = 7,
	isOnline = 3,
	trigger = 4,
	desc = 2,
	invalid = 5,
	parallel = 8,
	restart = 9,
	interruptFinish = 6
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
