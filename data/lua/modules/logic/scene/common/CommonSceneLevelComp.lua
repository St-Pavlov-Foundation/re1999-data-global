module("modules.logic.scene.common.CommonSceneLevelComp", package.seeall)

local var_0_0 = class("CommonSceneLevelComp", BaseSceneComp)

var_0_0.OnLevelLoaded = 1

local var_0_1 = "scenes/common/vx_prefabs/%s.prefab"

function var_0_0.onInit(arg_1_0)
	arg_1_0._sceneId = nil
	arg_1_0._levelId = nil
	arg_1_0._isLoadingRes = false
	arg_1_0._levelId = nil
	arg_1_0._resPath = nil
	arg_1_0._assetItem = nil
	arg_1_0._instGO = nil
end

function var_0_0.getCurLevelId(arg_2_0)
	return arg_2_0._levelId
end

function var_0_0.onSceneStart(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._sceneId = arg_3_1
	arg_3_0._levelId = arg_3_2
	arg_3_0._failCallback = arg_3_3

	arg_3_0:loadLevel(arg_3_2)
end

function var_0_0.onSceneClose(arg_4_0)
	if arg_4_0._isLoadingRes and arg_4_0._resPath then
		removeAssetLoadCb(arg_4_0._resPath, arg_4_0._onLoadCallback, arg_4_0)

		arg_4_0._isLoadingRes = nil
	end

	if arg_4_0._assetItem then
		gohelper.destroy(arg_4_0._instGO)
		arg_4_0._assetItem:Release()
	end

	arg_4_0._levelId = nil
	arg_4_0._resPath = nil
	arg_4_0._assetItem = nil
	arg_4_0._instGO = nil

	arg_4_0:releaseSceneEffectsLoader()
end

function var_0_0.loadLevel(arg_5_0, arg_5_1)
	if arg_5_0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (arg_5_0._levelId or "nil") .. ", try to load id = " .. (arg_5_1 or "nil"))

		return
	end

	if arg_5_0._assetItem then
		gohelper.destroy(arg_5_0._instGO)
		arg_5_0._assetItem:Release()

		arg_5_0._assetItem = nil
		arg_5_0._instGO = nil

		arg_5_0:releaseSceneEffectsLoader()
	end

	arg_5_0._isLoadingRes = true
	arg_5_0._levelId = arg_5_1

	arg_5_0:getCurScene():setCurLevelId(arg_5_0._levelId)

	arg_5_0._resPath = ResUrl.getSceneLevelUrl(arg_5_1)

	loadAbAsset(arg_5_0._resPath, false, arg_5_0._onLoadCallback, arg_5_0)
end

function var_0_0._onLoadCallback(arg_6_0, arg_6_1)
	arg_6_0._isLoadingRes = false

	if arg_6_1.IsLoadSuccess then
		arg_6_0._assetItem = arg_6_1

		arg_6_0._assetItem:Retain()

		local var_6_0 = arg_6_0:getCurScene():getSceneContainerGO()

		arg_6_0._instGO = gohelper.clone(arg_6_0._assetItem:GetResource(arg_6_0._resPath), var_6_0)

		arg_6_0:dispatchEvent(var_0_0.OnLevelLoaded, arg_6_0._levelId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, arg_6_0._levelId)

		local var_6_1 = SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()]
		local var_6_2 = arg_6_0._sceneId or -1
		local var_6_3 = arg_6_0._levelId or -1

		logNormal(string.format("load scene level finish: %s %d level_%d", var_6_1, var_6_2, var_6_3))

		local var_6_4 = lua_scene_level.configDict[var_6_3]

		if var_6_4 and not string.nilorempty(var_6_4.sceneEffects) then
			arg_6_0:releaseSceneEffectsLoader()

			local var_6_5 = string.split(var_6_4.sceneEffects, "#")

			arg_6_0._sceneEffectsLoader = MultiAbLoader.New()

			for iter_6_0, iter_6_1 in ipairs(var_6_5) do
				arg_6_0._sceneEffectsLoader:addPath(string.format(var_0_1, iter_6_1))
			end

			arg_6_0._sceneEffectsObj = {}

			arg_6_0._sceneEffectsLoader:setOneFinishCallback(arg_6_0._onSceneEffectsLoaded)
			arg_6_0._sceneEffectsLoader:startLoad(arg_6_0._onAllSceneEffectsLoaded, arg_6_0)
		end
	elseif arg_6_0._failCallback then
		arg_6_0._failCallback(arg_6_0)
	else
		logError("load scene level fail, level_" .. (arg_6_0._levelId or "nil"))
	end
end

function var_0_0._onSceneEffectsLoaded(arg_7_0, arg_7_1)
	if not gohelper.isNil(arg_7_0._instGO) then
		local var_7_0 = arg_7_1:getFirstAssetItem()
		local var_7_1 = var_7_0 and var_7_0:GetResource()

		if var_7_1 then
			table.insert(arg_7_0._sceneEffectsObj, gohelper.clone(var_7_1, arg_7_0._instGO))
		end
	end
end

function var_0_0._onAllSceneEffectsLoaded(arg_8_0)
	return
end

function var_0_0.releaseSceneEffectsLoader(arg_9_0)
	if arg_9_0._sceneEffectsLoader then
		arg_9_0._sceneEffectsLoader:dispose()

		arg_9_0._sceneEffectsLoader = nil
	end
end

function var_0_0.getSceneGo(arg_10_0)
	return arg_10_0._instGO
end

return var_0_0
