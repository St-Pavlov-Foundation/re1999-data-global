module("modules.configs.excel2json.lua_version_res_split", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	path = 8,
	guide = 4,
	videoPath = 7,
	audio = 2,
	folderPath = 6,
	uiFolder = 9,
	story = 5,
	chapter = 3,
	id = 1,
	uiPath = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
