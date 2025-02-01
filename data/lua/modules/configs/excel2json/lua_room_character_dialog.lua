module("modules.configs.excel2json.lua_room_character_dialog", package.seeall)

slot1 = {
	selectIds = 7,
	relateContent = 6,
	speaker = 3,
	stepId = 2,
	content = 4,
	critteremoji = 5,
	speakerType = 8,
	dialogId = 1,
	nextStepId = 9
}
slot2 = {
	"dialogId",
	"stepId"
}
slot3 = {
	speaker = 1,
	relateContent = 3,
	content = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
