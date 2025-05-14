module("modules.configs.excel2json.lua_room_interact_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	buildingId = 1,
	heroCount = 2,
	cameraId = 8,
	heroAnimStr = 6,
	interactType = 4,
	intervalTime = 3,
	buildingAnim = 7,
	showTime = 5
}
local var_0_2 = {
	"buildingId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
