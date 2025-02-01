module("modules.configs.excel2json.lua_activity154_options", package.seeall)

slot1 = {
	optionText = 3,
	optionId = 2,
	puzzleId = 1
}
slot2 = {
	"puzzleId",
	"optionId"
}
slot3 = {
	optionText = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
