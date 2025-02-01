module("modules.logic.scene.common.CommonSceneLevelComp", package.seeall)

slot0 = class("CommonSceneLevelComp", BaseSceneComp)
slot0.OnLevelLoaded = 1
slot1 = "scenes/common/vx_prefabs/%s.prefab"

function slot0.onInit(slot0)
	slot0._sceneId = nil
	slot0._levelId = nil
	slot0._isLoadingRes = false
	slot0._levelId = nil
	slot0._resPath = nil
	slot0._assetItem = nil
	slot0._instGO = nil
end

function slot0.getCurLevelId(slot0)
	return slot0._levelId
end

function slot0.onSceneStart(slot0, slot1, slot2, slot3)
	slot0._sceneId = slot1
	slot0._levelId = slot2
	slot0._failCallback = slot3

	slot0:loadLevel(slot2)
end

function slot0.onSceneClose(slot0)
	if slot0._isLoadingRes and slot0._resPath then
		removeAssetLoadCb(slot0._resPath, slot0._onLoadCallback, slot0)

		slot0._isLoadingRes = nil
	end

	if slot0._assetItem then
		gohelper.destroy(slot0._instGO)
		slot0._assetItem:Release()
	end

	slot0._levelId = nil
	slot0._resPath = nil
	slot0._assetItem = nil
	slot0._instGO = nil

	slot0:releaseSceneEffectsLoader()
end

function slot0.loadLevel(slot0, slot1)
	if slot0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (slot0._levelId or "nil") .. ", try to load id = " .. (slot1 or "nil"))

		return
	end

	if slot0._assetItem then
		gohelper.destroy(slot0._instGO)
		slot0._assetItem:Release()

		slot0._assetItem = nil
		slot0._instGO = nil

		slot0:releaseSceneEffectsLoader()
	end

	slot0._isLoadingRes = true
	slot0._levelId = slot1

	slot0:getCurScene():setCurLevelId(slot0._levelId)

	slot0._resPath = ResUrl.getSceneLevelUrl(slot1)

	loadAbAsset(slot0._resPath, false, slot0._onLoadCallback, slot0)
end

function slot0._onLoadCallback(slot0, slot1)
	slot0._isLoadingRes = false

	if slot1.IsLoadSuccess then
		slot0._assetItem = slot1

		slot0._assetItem:Retain()

		slot0._instGO = gohelper.clone(slot0._assetItem:GetResource(slot0._resPath), slot0:getCurScene():getSceneContainerGO())

		slot0:dispatchEvent(uv0.OnLevelLoaded, slot0._levelId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, slot0._levelId)

		slot5 = slot0._levelId or -1

		logNormal(string.format("load scene level finish: %s %d level_%d", SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()], slot0._sceneId or -1, slot5))

		if lua_scene_level.configDict[slot5] and not string.nilorempty(slot6.sceneEffects) then
			slot0:releaseSceneEffectsLoader()

			slot0._sceneEffectsLoader = MultiAbLoader.New()

			for slot11, slot12 in ipairs(string.split(slot6.sceneEffects, "#")) do
				slot0._sceneEffectsLoader:addPath(string.format(uv1, slot12))
			end

			slot0._sceneEffectsObj = {}

			slot0._sceneEffectsLoader:setOneFinishCallback(slot0._onSceneEffectsLoaded)
			slot0._sceneEffectsLoader:startLoad(slot0._onAllSceneEffectsLoaded, slot0)
		end
	elseif slot0._failCallback then
		slot0:_failCallback()
	else
		logError("load scene level fail, level_" .. (slot0._levelId or "nil"))
	end
end

function slot0._onSceneEffectsLoaded(slot0, slot1)
	if not gohelper.isNil(slot0._instGO) and slot1:getFirstAssetItem() and slot2:GetResource() then
		table.insert(slot0._sceneEffectsObj, gohelper.clone(slot3, slot0._instGO))
	end
end

function slot0._onAllSceneEffectsLoaded(slot0)
end

function slot0.releaseSceneEffectsLoader(slot0)
	if slot0._sceneEffectsLoader then
		slot0._sceneEffectsLoader:dispose()

		slot0._sceneEffectsLoader = nil
	end
end

function slot0.getSceneGo(slot0)
	return slot0._instGO
end

return slot0
