module("modules.configs.excel2json.lua_activity163_dialog", package.seeall)

slot1 = {
	expression = 9,
	content = 7,
	nextStep = 3,
	pos = 5,
	stepId = 2,
	condition = 8,
	speaker = 4,
	speakerIcon = 6,
	id = 1
}
slot2 = {
	"id",
	"stepId"
}
slot3 = {
	speaker = 1,
	content = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
