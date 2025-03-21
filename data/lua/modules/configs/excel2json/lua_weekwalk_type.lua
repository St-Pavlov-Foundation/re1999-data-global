module("modules.configs.excel2json.lua_weekwalk_type", package.seeall)

slot1 = {
	heroCd = 2,
	isRefresh = 5,
	starNum = 7,
	type = 1,
	showDetail = 6,
	canResetLayer = 4,
	star = 3
}
slot2 = {
	"type"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
