module("modules.configs.excel2json.lua_reward_group", package.seeall)

slot1 = {
	group = 2,
	materialId = 4,
	count = 5,
	shownum = 7,
	id = 1,
	label = 6,
	materialType = 3
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
