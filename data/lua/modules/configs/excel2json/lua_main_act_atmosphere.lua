module("modules.configs.excel2json.lua_main_act_atmosphere", package.seeall)

slot1 = {
	isShowLogo = 6,
	mainView = 3,
	mainViewActBtn = 4,
	mainViewActBtnPrefix = 5,
	id = 1,
	isShowActBg = 7,
	mainThumbnailView = 8,
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
