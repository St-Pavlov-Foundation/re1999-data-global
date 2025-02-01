module("modules.configs.excel2json.lua_weather_week", package.seeall)

slot1 = {
	id = 1,
	day6 = 7,
	day4 = 5,
	day5 = 6,
	day3 = 4,
	day1 = 2,
	day7 = 8,
	day2 = 3
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
