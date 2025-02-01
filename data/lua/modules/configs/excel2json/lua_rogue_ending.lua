module("modules.configs.excel2json.lua_rogue_ending", package.seeall)

slot1 = {
	endingDesc = 6,
	resultIcon = 5,
	storyId = 3,
	id = 1,
	title = 2,
	endingIcon = 4
}
slot2 = {
	"id"
}
slot3 = {
	endingDesc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
