module("modules.configs.excel2json.lua_block_task", package.seeall)

slot1 = {
	order = 4,
	isGuide = 5,
	id = 1,
	resourceId = 2,
	taskType = 3
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
