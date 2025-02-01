module("modules.configs.excel2json.lua_scene_level", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
