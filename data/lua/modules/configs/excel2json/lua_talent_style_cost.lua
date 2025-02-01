module("modules.configs.excel2json.lua_talent_style_cost", package.seeall)

slot1 = {
	styleId = 2,
	heroId = 1,
	consume = 3
}
slot2 = {
	"heroId",
	"styleId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
