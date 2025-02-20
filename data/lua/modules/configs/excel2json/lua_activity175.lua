module("modules.configs.excel2json.lua_activity175", package.seeall)

slot1 = {
	res_gif1 = 3,
	res_pic = 2,
	activityId = 1,
	res_gif2 = 4
}
slot2 = {
	"activityId",
	"res_pic"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
