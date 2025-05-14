module("modules.configs.excel2json.lua_scene_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	ambientSound = 22,
	spineR = 9,
	cardCamera = 7,
	weatherEffect = 18,
	sceneId = 4,
	spineG = 10,
	useBloom = 8,
	bgm = 21,
	sceneType = 3,
	cameraId = 5,
	sceneEffects = 23,
	bloomEffect = 17,
	resName = 2,
	flyEffect = 19,
	bloomB = 14,
	bloomA = 15,
	bloomR = 12,
	cameraOffset = 6,
	flickerSceneFactor = 16,
	wadeEffect = 20,
	spineB = 11,
	id = 1,
	bloomG = 13
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
