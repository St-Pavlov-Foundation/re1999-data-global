module("modules.configs.excel2json.lua_skin_weather_param", package.seeall)

slot1 = {
	emissionColor3 = 12,
	bloomColor3 = 4,
	mainColor1 = 6,
	mainColor2 = 7,
	emissionColor1 = 10,
	bloomColor1 = 2,
	emissionColor4 = 13,
	bloomColor4 = 5,
	mainColor3 = 8,
	emissionColor2 = 11,
	bloomColor2 = 3,
	id = 1,
	mainColor4 = 9
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
