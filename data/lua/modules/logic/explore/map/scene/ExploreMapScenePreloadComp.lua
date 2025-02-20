module("modules.logic.explore.map.scene.ExploreMapScenePreloadComp", package.seeall)

slot0 = class("ExploreMapScenePreloadComp", LuaCompBase)
slot1 = "scenes/dynamic/textures/empty_white.png"
slot2 = 0.01
slot3 = 0.3
slot4 = 20
slot5 = 2
slot6 = 15
slot7 = 1

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.showRage = Vector4.New(0, 0, 6, 6)
	slot0._allObjDic = {}
	slot0._allMajorDic = {}
	slot0._allShadowObjDic = {}
	slot0._lightMapObjs = {}
	slot0._lightmapUseByDic = {}
	slot0._lightMapCSArr = nil
	slot0.showObjIdDict = {}
	slot3 = lua_scene_level.configDict[GameSceneMgr.instance:getCurLevelId()]

	if SLFramework.FrameworkSettings.IsEditor and SLFramework.FileHelper.IsFileExists(SLFramework.FrameworkSettings.ProjLuaRootDir .. "/modules/configs/explore/lua_explore_scene_" .. slot3.resName .. ".lua") == false then
		slot0.hasInit = false

		logError("congfig not find :" .. slot4)

		return
	end

	slot0._config = addGlobalModule("modules.configs.explore.lua_explore_scene_" .. slot3.resName)
	slot0.hasInit = true
	slot0._waitAtiveDict = {}
	slot0.camera = CameraMgr.instance:getMainCamera()
	slot0._lights = nil

	if GameSceneMgr.instance:getCurScene() then
		slot0._lights = slot5.level:getSceneGo():GetComponentsInChildren(typeof(UnityEngine.Light))
	end

	slot0._lightmapABPath = "explore/scene/" .. slot3.resName
	slot0._lightMapLoader = MultiAbLoader.New()

	for slot9, slot10 in ipairs(slot0._config.lightmapList) do
		slot0._lightmapUseByDic[slot9] = {}

		if GameResMgr.IsFromEditorDir then
			slot0._lightMapLoader:addPath(slot10[1])
			slot0._lightMapLoader:addPath(slot10[2])
		end
	end

	if not GameResMgr.IsFromEditorDir and #slot0._config.lightmapList > 0 then
		slot0._lightMapLoader:addPath(slot0._lightmapABPath)
	end

	slot0._lightMapLoader:addPath(uv0)
	slot0._lightMapLoader:startLoad(slot0._initLightMap, slot0)

	for slot11, slot12 in ipairs(slot0._config.objList) do
		slot13 = gohelper.create3d(slot0.go, "sceneObj")

		if slot12.areaId and slot12.areaId > 0 then
			slot13 = ExploreController.instance:getMap():getContainRootByAreaId(slot12.areaId).sceneObj
		end

		slot14 = ExploreMapSceneObj.New(slot13)

		slot14:setData(slot12)

		slot0._allObjDic[slot12.id] = slot14

		if slot12.major == 1 then
			slot0._allMajorDic[slot12.id] = true
		end

		if ExploreConstValue.MapSceneObjAlwaysShowEffectType[slot14.effectType] then
			slot14:show()
		end
	end

	slot0:_buildTree()

	if slot0._config.shadowObjs then
		for slot11, slot12 in ipairs(slot0._config.shadowObjs) do
			slot13 = slot6

			if slot12.areaId and slot12.areaId > 0 then
				slot13 = slot7:getContainRootByAreaId(slot12.areaId).sceneObj
			end

			slot14 = ExploreMapShadowObj.New(slot13)

			slot14:setData(slot12)

			slot0._allShadowObjDic[slot12.id] = slot14
		end
	end

	slot0:addEventListeners()
end

function slot0.addEventListeners(slot0)
	if slot0.hasInit then
		slot0:addEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, slot0.updateCameraPos, slot0)
		slot0:addEventCb(ExploreController.instance, ExploreEvent.ShowSceneObj, slot0.showSceneObj, slot0)
		slot0:addEventCb(ExploreController.instance, ExploreEvent.HideSceneObj, slot0.hideSceneObj, slot0)
		slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
		TaskDispatcher.runRepeat(slot0._checkActive, slot0, uv0)
	end
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, slot0.updateCameraPos, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.ShowSceneObj, slot0.showSceneObj, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.HideSceneObj, slot0.hideSceneObj, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.SceneObjLoadedCb, slot0.SceneObjLoadedCb, slot0)
	TaskDispatcher.cancelTask(slot0._checkActive, slot0)
end

function slot0.showSceneObj(slot0, slot1)
	slot2 = slot0._allObjDic[slot1]

	slot2:markShow()

	slot0._waitAtiveDict[slot1] = true

	slot0:_updateLightMapUseBy(slot2, true)
end

function slot0.hideSceneObj(slot0, slot1)
	slot0._waitAtiveDict[slot1] = nil

	if ExploreConstValue.MapSceneObjAlwaysShowEffectType[slot0._allObjDic[slot1].effectType] ~= true and slot2:hide() then
		slot0:_updateLightMapUseBy(slot2, false)
	end
end

function slot0._onScreenResize(slot0)
	slot0:updateCameraPos(slot0._targetPos)
end

function slot0.updateCameraPos(slot0, slot1)
	slot0._targetPos = slot1 or slot0._targetPos
	slot0.showRage.x = slot0._targetPos.x
	slot0.showRage.y = slot0._targetPos.z

	if slot0._targetPos == nil then
		slot0:_firstInitMap()
	elseif slot0.markDelayUpdate ~= true then
		slot0.markDelayUpdate = true

		TaskDispatcher.runDelay(slot0._delayUpdate, slot0, uv0)
	end
end

function slot0._firstInitMap(slot0)
	slot0.leftInitActiveNum = slot0:calcNeedLoadedSceneObj()

	if slot0.leftInitActiveNum > 0 then
		slot0:addEventCb(ExploreController.instance, ExploreEvent.SceneObjLoadedCb, slot0.SceneObjLoadedCb, slot0)
	end
end

function slot0.calcNeedLoadedSceneObj(slot0)
	slot0.markDelayUpdate = false

	slot0:_delayUpdate()
	TaskDispatcher.cancelTask(slot0._delayUpdate, slot0)

	return slot0:_checkActive(tabletool.len(slot0._waitAtiveDict))
end

function slot0.SceneObjLoadedCb(slot0)
	slot0.leftInitActiveNum = slot0.leftInitActiveNum - 1

	if slot0.leftInitActiveNum <= 0 then
		ExploreController.instance:dispatchEvent(ExploreEvent.InitMapDone)
		slot0:removeEventCb(ExploreController.instance, ExploreEvent.SceneObjLoadedCb, slot0.SceneObjLoadedCb, slot0)
	end
end

function slot0.clearUnUseObj(slot0)
	for slot4, slot5 in pairs(slot0._allObjDic) do
		slot5:unloadnow()
	end
end

slot8 = LuaProfiler.GetID("RebuildFrustumPlanes")
slot9 = LuaProfiler.GetID("GetTreeCheckResult")
slot10 = LuaProfiler.GetID("GetTreeCheckResult_For")

function slot0._delayUpdate(slot0)
	if ExploreConstValue.UseCSharpTree then
		slot1 = CameraMgr.instance:getMainCamera()

		LuaProfiler.BeginSample(uv3)

		slot11 = slot1.fieldOfView + uv0

		ZProj.ExploreHelper.RebuildFrustumPlanes(slot1, uv1, uv2, slot11, slot1.aspect)
		LuaProfiler.EndSample()
		LuaProfiler.BeginSample(uv4)

		slot6, slot7 = ZProj.ExploreHelper.GetTreeCheckResult(slot0.showRage, 1)

		LuaProfiler.EndSample()
		LuaProfiler.BeginSample(uv5)

		for slot11 = 0, slot7 - 1 do
			if slot0._allObjDic[slot6[slot11] + 1].ishide == true then
				slot0:showSceneObj(slot12)
			else
				slot0:hideSceneObj(slot12)
			end
		end

		LuaProfiler.EndSample()
	else
		for slot4, slot5 in pairs(slot0.showObjIdDict) do
			slot0.showObjIdDict[slot4] = 0
		end

		slot4 = slot0.showRage

		slot0._tree:triggerMove(slot4, slot0.showObjIdDict)

		for slot4 in pairs(slot0._allObjDic) do
			if slot0.showObjIdDict[slot4] == 1 then
				slot0:showSceneObj(slot4)
			else
				slot0:hideSceneObj(slot4)
			end
		end
	end

	slot0:_updateLightMap()
	slot0:_updateShadow()

	slot0.markDelayUpdate = false
end

function slot0._buildTree(slot0)
	if ExploreConstValue.UseCSharpTree then
		ZProj.ExploreHelper.InitTreeObj(slot0._config.tree, #slot0._allObjDic)
	else
		slot0._tree = ExploreMapTree.New()

		slot0._tree:setup(slot0._config.tree, slot0)
	end
end

function slot0._updateShadow(slot0)
	if slot0._lights then
		slot8 = 25
		slot9 = 0.01

		ZProj.ExploreHelper.RebuildDirectionalCullingPlanes(slot0.camera, slot8, slot9, slot0.camera.fieldOfView + 2, slot0.camera.aspect, slot0._lights)

		for slot8, slot9 in pairs(slot0._allShadowObjDic) do
			if ZProj.ExploreHelper.CheckBoundIsInDirectionalCullingPlanes(slot9.bounds) then
				slot9:show()
			else
				slot9:hide()
			end
		end
	end
end

function slot0._initLightMap(slot0)
	if #slot0._config.lightmapList <= 0 then
		UnityEngine.LightmapSettings.lightmaps = tolua.toarray({}, typeof(UnityEngine.LightmapData))

		ExploreController.instance:dispatchEvent(ExploreEvent.UpdateLightMap, 0)

		return
	end

	slot2 = slot0._lightMapLoader:getAssetItem(slot0._lightmapABPath)
	slot3 = slot0._lightMapLoader:getAssetItem(slot0._lightmapABPath)
	slot4 = slot0._lightMapLoader:getAssetItem(uv0):GetResource(uv0)
	slot5 = {}

	for slot9, slot10 in ipairs(slot0._config.lightmapList) do
		slot11 = UnityEngine.LightmapData()
		slot11.lightmapColor = slot4
		slot11.lightmapDir = slot4

		if GameResMgr.IsFromEditorDir then
			slot2 = slot0._lightMapLoader:getAssetItem(slot10[1])
			slot3 = slot0._lightMapLoader:getAssetItem(slot10[2])
		end

		slot5[slot9] = slot11
		slot0._lightMapObjs[slot9] = ExploreMapLightMapObj.New(slot11, slot10, slot4, slot2, slot3)
	end

	slot0._lightMapCSArr = tolua.toarray(slot5, typeof(UnityEngine.LightmapData))
	UnityEngine.LightmapSettings.lightmaps = slot0._lightMapCSArr

	slot0:_updateLightMap()
end

function slot0._updateLightMapUseBy(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1.useLightMapIndexList) do
		if slot8 + 1 > 0 then
			if slot2 then
				slot0._lightmapUseByDic[slot8][slot1.id] = true
			else
				slot0._lightmapUseByDic[slot8][slot1.id] = nil
			end
		end
	end
end

function slot0._updateLightMap(slot0)
	for slot5, slot6 in ipairs(slot0._lightMapObjs) do
		if tabletool.len(slot0._lightmapUseByDic[slot5]) > 0 then
			slot6:show()

			slot1 = 0 + 1
		elseif slot7 == 0 then
			slot6:hide()
		end
	end

	UnityEngine.LightmapSettings.lightmaps = slot0._lightMapCSArr

	ExploreController.instance:dispatchEvent(ExploreEvent.UpdateLightMap, slot1)
end

function slot0._checkActive(slot0, slot1)
	slot1 = slot1 or uv0
	slot2 = 0

	if next(slot0._waitAtiveDict) then
		for slot6 in pairs(slot0._waitAtiveDict) do
			if slot1 == 0 then
				break
			end

			if slot0._allMajorDic[slot6] then
				slot0._waitAtiveDict[slot6] = nil

				if slot0._allObjDic[slot6].ishide == false and slot7:show() then
					slot2 = slot2 + 1
					slot1 = slot1 - 1
				end
			end
		end

		for slot6 in pairs(slot0._waitAtiveDict) do
			if slot1 == 0 then
				break
			end

			slot0._waitAtiveDict[slot6] = nil

			if slot0._allObjDic[slot6].ishide == false and slot7:show() then
				slot2 = slot2 + 1
				slot1 = slot1 - 1
			end
		end
	end

	return slot2
end

function slot0._getFirstActive(slot0)
	slot1 = next(slot0._waitAtiveDict)

	while slot1 do
		slot0._waitAtiveDict[slot1] = nil

		if slot0._allObjDic[slot1].ishide == false then
			return slot2
		end

		slot1 = next(slot0._waitAtiveDict)
	end
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in pairs(slot0._allObjDic) do
		slot5:dispose()
	end

	for slot4, slot5 in pairs(slot0._lightMapObjs) do
		slot5:dispose()
	end

	for slot4, slot5 in pairs(slot0._allShadowObjDic) do
		slot5:dispose()
	end

	TaskDispatcher.cancelTask(slot0._delayUpdate, slot0)

	if slot0._tree then
		slot0._tree:onDestroy()
	end

	slot0._tree = nil
	slot0._waitAtiveDict = nil
	slot0._allObjDic = nil
	slot0._lightMapObjs = nil
	slot0._allShadowObjDic = nil
	slot0._lightMapCSArr = nil

	if slot0._lightMapLoader then
		slot0._lightMapLoader:dispose()
	end

	slot0._lightMapLoader = nil
end

return slot0
