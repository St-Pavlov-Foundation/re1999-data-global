module("modules.configs.excel2json.lua_activity134_story", package.seeall)

slot1 = {
	storyType = 2,
	charaterIcon = 4,
	id = 1,
	formMan = 5,
	desc = 3
}
slot2 = {
	"id",
	"storyType"
}
slot3 = {
	formMan = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
