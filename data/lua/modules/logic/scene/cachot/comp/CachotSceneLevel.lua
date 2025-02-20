module("modules.logic.scene.cachot.comp.CachotSceneLevel", package.seeall)

slot0 = class("CachotSceneLevel", CommonSceneLevelComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._eventTrs = {}

	uv0.super.onSceneStart(slot0, slot1, slot2)
end

function slot0.switchLevel(slot0, slot1)
	if slot1 == slot0._levelId then
		if not slot0._isLoadingRes then
			slot0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, slot0._levelId)
			GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, slot0._levelId)
		end

		return
	end

	if slot0._isLoadingRes then
		slot0._levelId = nil
		slot0._isLoadingRes = nil

		removeAssetLoadCb(slot0._resPath, slot0._onLoadCallback, slot0)
	end

	slot0._eventTrs = {}

	slot0:loadLevel(slot1)
end

function slot0._onLoadCallback(slot0, slot1)
	slot0._isLoadingRes = false

	if slot1.IsLoadSuccess then
		slot0._assetItem = slot1

		slot0._assetItem:Retain()

		slot7 = "CachotLevel"
		slot0._instGO = gohelper.clone(slot0._assetItem:GetResource(slot0._resPath), slot0:getCurScene():getSceneContainerGO(), slot7)
		slot3 = slot0._instGO

		for slot7 = 1, 3 do
			if not gohelper.findChild(slot3, "Obj-Plant/event/" .. slot7) then
				if slot7 == 1 then
					gohelper.create3d(gohelper.findChild(slot3, "Obj-Plant"), tostring(slot7)).transform.localPosition = Vector3.New(28, -7, 1)
				elseif slot7 == 2 then
					slot8.transform.localPosition = Vector3.New(32, -7, 1)
				elseif slot7 == 3 then
					slot8.transform.localPosition = Vector3.New(36, -7, 1)
				end
			end

			slot0._eventTrs[slot7] = slot8.transform
		end

		slot0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, slot0._levelId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, slot0._levelId)
		logNormal(string.format("load scene level finish: %s %d level_%d", SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()], slot0._sceneId or -1, slot0._levelId or -1))
	else
		logError("load scene level fail, level_" .. (slot0._levelId or "nil"))
	end
end

function slot0.getEventTr(slot0, slot1)
	return slot0._eventTrs[slot1]
end

function slot0.onSceneClose(slot0)
	slot0._eventTrs = {}

	uv0.super.onSceneClose(slot0)
end

return slot0
