module("modules.configs.excel2json.lua_activity163_bubble", package.seeall)

slot1 = {
	stepId = 2,
	direction = 5,
	nextStep = 3,
	content = 6,
	id = 1,
	bubbleType = 4
}
slot2 = {
	"id",
	"stepId"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
