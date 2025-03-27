module("modules.configs.excel2json.lua_main_act_atmosphere", package.seeall)

slot1 = {
	mainThumbnailView = 6,
	mainView = 3,
	isShowActBg = 5,
	isShowLogo = 4,
	id = 1,
	effectDuration = 2
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
