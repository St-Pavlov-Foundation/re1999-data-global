module("modules.configs.excel2json.lua_activity166_word_effect", package.seeall)

slot1 = {
	id = 2,
	type = 4,
	activityId = 1,
	desc = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
