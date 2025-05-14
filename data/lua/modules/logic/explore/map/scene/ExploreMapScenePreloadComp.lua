module("modules.logic.explore.map.scene.ExploreMapScenePreloadComp", package.seeall)

local var_0_0 = class("ExploreMapScenePreloadComp", LuaCompBase)
local var_0_1 = "scenes/dynamic/textures/empty_white.png"
local var_0_2 = 0.01
local var_0_3 = 0.3
local var_0_4 = 20
local var_0_5 = 2
local var_0_6 = 15
local var_0_7 = 1

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.showRage = Vector4.New(0, 0, 6, 6)
	arg_1_0._allObjDic = {}
	arg_1_0._allMajorDic = {}
	arg_1_0._allShadowObjDic = {}
	arg_1_0._lightMapObjs = {}
	arg_1_0._lightmapUseByDic = {}
	arg_1_0._lightMapCSArr = nil
	arg_1_0.showObjIdDict = {}

	local var_1_0 = GameSceneMgr.instance:getCurLevelId()
	local var_1_1 = lua_scene_level.configDict[var_1_0]

	if SLFramework.FrameworkSettings.IsEditor then
		local var_1_2 = SLFramework.FrameworkSettings.ProjLuaRootDir .. "/modules/configs/explore/lua_explore_scene_" .. var_1_1.resName .. ".lua"

		if SLFramework.FileHelper.IsFileExists(var_1_2) == false then
			arg_1_0.hasInit = false

			logError("congfig not find :" .. var_1_2)

			return
		end
	end

	local var_1_3 = "modules.configs.explore.lua_explore_scene_" .. var_1_1.resName

	arg_1_0._config = addGlobalModule(var_1_3)
	arg_1_0.hasInit = true
	arg_1_0._waitAtiveDict = {}
	arg_1_0.camera = CameraMgr.instance:getMainCamera()

	local var_1_4 = GameSceneMgr.instance:getCurScene()

	arg_1_0._lights = nil

	if var_1_4 then
		arg_1_0._lights = var_1_4.level:getSceneGo():GetComponentsInChildren(typeof(UnityEngine.Light))
	end

	arg_1_0._lightmapABPath = "explore/scene/" .. var_1_1.resName
	arg_1_0._lightMapLoader = MultiAbLoader.New()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._config.lightmapList) do
		arg_1_0._lightmapUseByDic[iter_1_0] = {}

		if GameResMgr.IsFromEditorDir then
			arg_1_0._lightMapLoader:addPath(iter_1_1[1])
			arg_1_0._lightMapLoader:addPath(iter_1_1[2])
		end
	end

	if not GameResMgr.IsFromEditorDir and #arg_1_0._config.lightmapList > 0 then
		arg_1_0._lightMapLoader:addPath(arg_1_0._lightmapABPath)
	end

	arg_1_0._lightMapLoader:addPath(var_0_1)
	arg_1_0._lightMapLoader:startLoad(arg_1_0._initLightMap, arg_1_0)

	local var_1_5 = gohelper.create3d(arg_1_0.go, "sceneObj")
	local var_1_6 = ExploreController.instance:getMap()

	for iter_1_2, iter_1_3 in ipairs(arg_1_0._config.objList) do
		local var_1_7 = var_1_5

		if iter_1_3.areaId and iter_1_3.areaId > 0 then
			var_1_7 = var_1_6:getContainRootByAreaId(iter_1_3.areaId).sceneObj
		end

		local var_1_8 = ExploreMapSceneObj.New(var_1_7)

		var_1_8:setData(iter_1_3)

		arg_1_0._allObjDic[iter_1_3.id] = var_1_8

		if iter_1_3.major == 1 then
			arg_1_0._allMajorDic[iter_1_3.id] = true
		end

		if ExploreConstValue.MapSceneObjAlwaysShowEffectType[var_1_8.effectType] then
			var_1_8:show()
		end
	end

	arg_1_0:_buildTree()

	if arg_1_0._config.shadowObjs then
		for iter_1_4, iter_1_5 in ipairs(arg_1_0._config.shadowObjs) do
			local var_1_9 = var_1_5

			if iter_1_5.areaId and iter_1_5.areaId > 0 then
				var_1_9 = var_1_6:getContainRootByAreaId(iter_1_5.areaId).sceneObj
			end

			local var_1_10 = ExploreMapShadowObj.New(var_1_9)

			var_1_10:setData(iter_1_5)

			arg_1_0._allShadowObjDic[iter_1_5.id] = var_1_10
		end
	end

	arg_1_0:addEventListeners()
end

function var_0_0.addEventListeners(arg_2_0)
	if arg_2_0.hasInit then
		arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, arg_2_0.updateCameraPos, arg_2_0)
		arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.ShowSceneObj, arg_2_0.showSceneObj, arg_2_0)
		arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.HideSceneObj, arg_2_0.hideSceneObj, arg_2_0)
		arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
		TaskDispatcher.runRepeat(arg_2_0._checkActive, arg_2_0, var_0_2)
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, arg_3_0.updateCameraPos, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.ShowSceneObj, arg_3_0.showSceneObj, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.HideSceneObj, arg_3_0.hideSceneObj, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.SceneObjLoadedCb, arg_3_0.SceneObjLoadedCb, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkActive, arg_3_0)
end

function var_0_0.showSceneObj(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._allObjDic[arg_4_1]

	var_4_0:markShow()

	arg_4_0._waitAtiveDict[arg_4_1] = true

	arg_4_0:_updateLightMapUseBy(var_4_0, true)
end

function var_0_0.hideSceneObj(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._allObjDic[arg_5_1]

	arg_5_0._waitAtiveDict[arg_5_1] = nil

	if ExploreConstValue.MapSceneObjAlwaysShowEffectType[var_5_0.effectType] ~= true and var_5_0:hide() then
		arg_5_0:_updateLightMapUseBy(var_5_0, false)
	end
end

function var_0_0._onScreenResize(arg_6_0)
	arg_6_0:updateCameraPos(arg_6_0._targetPos)
end

function var_0_0.updateCameraPos(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._targetPos == nil

	arg_7_0._targetPos = arg_7_1 or arg_7_0._targetPos
	arg_7_0.showRage.x = arg_7_0._targetPos.x
	arg_7_0.showRage.y = arg_7_0._targetPos.z

	if var_7_0 then
		arg_7_0:_firstInitMap()
	elseif arg_7_0.markDelayUpdate ~= true then
		arg_7_0.markDelayUpdate = true

		TaskDispatcher.runDelay(arg_7_0._delayUpdate, arg_7_0, var_0_3)
	end
end

function var_0_0._firstInitMap(arg_8_0)
	arg_8_0.leftInitActiveNum = arg_8_0:calcNeedLoadedSceneObj()

	if arg_8_0.leftInitActiveNum > 0 then
		arg_8_0:addEventCb(ExploreController.instance, ExploreEvent.SceneObjLoadedCb, arg_8_0.SceneObjLoadedCb, arg_8_0)
	end
end

function var_0_0.calcNeedLoadedSceneObj(arg_9_0)
	arg_9_0.markDelayUpdate = false

	arg_9_0:_delayUpdate()
	TaskDispatcher.cancelTask(arg_9_0._delayUpdate, arg_9_0)

	return arg_9_0:_checkActive(tabletool.len(arg_9_0._waitAtiveDict))
end

function var_0_0.SceneObjLoadedCb(arg_10_0)
	arg_10_0.leftInitActiveNum = arg_10_0.leftInitActiveNum - 1

	if arg_10_0.leftInitActiveNum <= 0 then
		ExploreController.instance:dispatchEvent(ExploreEvent.InitMapDone)
		arg_10_0:removeEventCb(ExploreController.instance, ExploreEvent.SceneObjLoadedCb, arg_10_0.SceneObjLoadedCb, arg_10_0)
	end
end

function var_0_0.clearUnUseObj(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._allObjDic) do
		iter_11_1:unloadnow()
	end
end

local var_0_8 = LuaProfiler.GetID("RebuildFrustumPlanes")
local var_0_9 = LuaProfiler.GetID("GetTreeCheckResult")
local var_0_10 = LuaProfiler.GetID("GetTreeCheckResult_For")

function var_0_0._delayUpdate(arg_12_0)
	if ExploreConstValue.UseCSharpTree then
		local var_12_0 = CameraMgr.instance:getMainCamera()
		local var_12_1 = var_12_0.fieldOfView + var_0_5
		local var_12_2 = var_12_0.aspect
		local var_12_3 = var_0_6
		local var_12_4 = var_0_7

		LuaProfiler.BeginSample(var_0_8)
		ZProj.ExploreHelper.RebuildFrustumPlanes(var_12_0, var_12_3, var_12_4, var_12_1, var_12_2)
		LuaProfiler.EndSample()
		LuaProfiler.BeginSample(var_0_9)

		local var_12_5, var_12_6 = ZProj.ExploreHelper.GetTreeCheckResult(arg_12_0.showRage, 1)

		LuaProfiler.EndSample()
		LuaProfiler.BeginSample(var_0_10)

		for iter_12_0 = 0, var_12_6 - 1 do
			local var_12_7 = var_12_5[iter_12_0] + 1

			if arg_12_0._allObjDic[var_12_7].ishide == true then
				arg_12_0:showSceneObj(var_12_7)
			else
				arg_12_0:hideSceneObj(var_12_7)
			end
		end

		LuaProfiler.EndSample()
	else
		for iter_12_1, iter_12_2 in pairs(arg_12_0.showObjIdDict) do
			arg_12_0.showObjIdDict[iter_12_1] = 0
		end

		arg_12_0._tree:triggerMove(arg_12_0.showRage, arg_12_0.showObjIdDict)

		for iter_12_3 in pairs(arg_12_0._allObjDic) do
			if arg_12_0.showObjIdDict[iter_12_3] == 1 then
				arg_12_0:showSceneObj(iter_12_3)
			else
				arg_12_0:hideSceneObj(iter_12_3)
			end
		end
	end

	arg_12_0:_updateLightMap()
	arg_12_0:_updateShadow()

	arg_12_0.markDelayUpdate = false
end

function var_0_0._buildTree(arg_13_0)
	if ExploreConstValue.UseCSharpTree then
		ZProj.ExploreHelper.InitTreeObj(arg_13_0._config.tree, #arg_13_0._allObjDic)
	else
		arg_13_0._tree = ExploreMapTree.New()

		arg_13_0._tree:setup(arg_13_0._config.tree, arg_13_0)
	end
end

function var_0_0._updateShadow(arg_14_0)
	if arg_14_0._lights then
		local var_14_0 = arg_14_0.camera.fieldOfView + 2
		local var_14_1 = arg_14_0.camera.aspect
		local var_14_2 = 25
		local var_14_3 = 0.01

		ZProj.ExploreHelper.RebuildDirectionalCullingPlanes(arg_14_0.camera, var_14_2, var_14_3, var_14_0, var_14_1, arg_14_0._lights)

		for iter_14_0, iter_14_1 in pairs(arg_14_0._allShadowObjDic) do
			if ZProj.ExploreHelper.CheckBoundIsInDirectionalCullingPlanes(iter_14_1.bounds) then
				iter_14_1:show()
			else
				iter_14_1:hide()
			end
		end
	end
end

function var_0_0._initLightMap(arg_15_0)
	if #arg_15_0._config.lightmapList <= 0 then
		UnityEngine.LightmapSettings.lightmaps = tolua.toarray({}, typeof(UnityEngine.LightmapData))

		ExploreController.instance:dispatchEvent(ExploreEvent.UpdateLightMap, 0)

		return
	end

	local var_15_0 = arg_15_0._lightMapLoader:getAssetItem(var_0_1)
	local var_15_1 = arg_15_0._lightMapLoader:getAssetItem(arg_15_0._lightmapABPath)
	local var_15_2 = arg_15_0._lightMapLoader:getAssetItem(arg_15_0._lightmapABPath)
	local var_15_3 = var_15_0:GetResource(var_0_1)
	local var_15_4 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._config.lightmapList) do
		local var_15_5 = UnityEngine.LightmapData()

		var_15_5.lightmapColor = var_15_3
		var_15_5.lightmapDir = var_15_3

		if GameResMgr.IsFromEditorDir then
			var_15_1 = arg_15_0._lightMapLoader:getAssetItem(iter_15_1[1])
			var_15_2 = arg_15_0._lightMapLoader:getAssetItem(iter_15_1[2])
		end

		local var_15_6 = ExploreMapLightMapObj.New(var_15_5, iter_15_1, var_15_3, var_15_1, var_15_2)

		var_15_4[iter_15_0] = var_15_5
		arg_15_0._lightMapObjs[iter_15_0] = var_15_6
	end

	arg_15_0._lightMapCSArr = tolua.toarray(var_15_4, typeof(UnityEngine.LightmapData))
	UnityEngine.LightmapSettings.lightmaps = arg_15_0._lightMapCSArr

	arg_15_0:_updateLightMap()
end

function var_0_0._updateLightMapUseBy(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.useLightMapIndexList

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		iter_16_1 = iter_16_1 + 1

		if iter_16_1 > 0 then
			if arg_16_2 then
				arg_16_0._lightmapUseByDic[iter_16_1][arg_16_1.id] = true
			else
				arg_16_0._lightmapUseByDic[iter_16_1][arg_16_1.id] = nil
			end
		end
	end
end

function var_0_0._updateLightMap(arg_17_0)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._lightMapObjs) do
		local var_17_1 = tabletool.len(arg_17_0._lightmapUseByDic[iter_17_0])

		if var_17_1 > 0 then
			iter_17_1:show()

			var_17_0 = var_17_0 + 1
		elseif var_17_1 == 0 then
			iter_17_1:hide()
		end
	end

	UnityEngine.LightmapSettings.lightmaps = arg_17_0._lightMapCSArr

	ExploreController.instance:dispatchEvent(ExploreEvent.UpdateLightMap, var_17_0)
end

function var_0_0._checkActive(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or var_0_4

	local var_18_0 = 0

	if next(arg_18_0._waitAtiveDict) then
		for iter_18_0 in pairs(arg_18_0._waitAtiveDict) do
			if arg_18_1 == 0 then
				break
			end

			if arg_18_0._allMajorDic[iter_18_0] then
				local var_18_1 = arg_18_0._allObjDic[iter_18_0]

				arg_18_0._waitAtiveDict[iter_18_0] = nil

				if var_18_1.ishide == false and var_18_1:show() then
					var_18_0 = var_18_0 + 1
					arg_18_1 = arg_18_1 - 1
				end
			end
		end

		for iter_18_1 in pairs(arg_18_0._waitAtiveDict) do
			if arg_18_1 == 0 then
				break
			end

			local var_18_2 = arg_18_0._allObjDic[iter_18_1]

			arg_18_0._waitAtiveDict[iter_18_1] = nil

			if var_18_2.ishide == false and var_18_2:show() then
				var_18_0 = var_18_0 + 1
				arg_18_1 = arg_18_1 - 1
			end
		end
	end

	return var_18_0
end

function var_0_0._getFirstActive(arg_19_0)
	local var_19_0 = next(arg_19_0._waitAtiveDict)

	while var_19_0 do
		arg_19_0._waitAtiveDict[var_19_0] = nil

		local var_19_1 = arg_19_0._allObjDic[var_19_0]

		if var_19_1.ishide == false then
			return var_19_1
		end

		var_19_0 = next(arg_19_0._waitAtiveDict)
	end
end

function var_0_0.onDestroy(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._allObjDic) do
		iter_20_1:dispose()
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0._lightMapObjs) do
		iter_20_3:dispose()
	end

	for iter_20_4, iter_20_5 in pairs(arg_20_0._allShadowObjDic) do
		iter_20_5:dispose()
	end

	TaskDispatcher.cancelTask(arg_20_0._delayUpdate, arg_20_0)

	if arg_20_0._tree then
		arg_20_0._tree:onDestroy()
	end

	arg_20_0._tree = nil
	arg_20_0._waitAtiveDict = nil
	arg_20_0._allObjDic = nil
	arg_20_0._lightMapObjs = nil
	arg_20_0._allShadowObjDic = nil
	arg_20_0._lightMapCSArr = nil

	if arg_20_0._lightMapLoader then
		arg_20_0._lightMapLoader:dispose()
	end

	arg_20_0._lightMapLoader = nil
end

return var_0_0
