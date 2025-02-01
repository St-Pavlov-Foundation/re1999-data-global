module("modules.configs.excel2json.lua_activity115_chapter", package.seeall)

slot1 = {
	id = 2,
	name = 3,
	ambientAudio = 6,
	name_En = 4,
	activityId = 1,
	openId = 5
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
