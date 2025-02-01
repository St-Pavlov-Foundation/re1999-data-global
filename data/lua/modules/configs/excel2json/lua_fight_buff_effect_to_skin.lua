module("modules.configs.excel2json.lua_fight_buff_effect_to_skin", package.seeall)

slot1 = {
	buffId = 1,
	skinIdList = 2
}
slot2 = {
	"buffId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
