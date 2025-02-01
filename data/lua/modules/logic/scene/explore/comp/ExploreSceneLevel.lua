module("modules.logic.scene.explore.comp.ExploreSceneLevel", package.seeall)

slot0 = class("ExploreSceneLevel", CommonSceneLevelComp)

function slot0.init(slot0, slot1, slot2)
	slot0:loadLevel(slot2)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._sceneId = slot1
	slot0._levelId = slot2
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
	end

	slot0._isLoadingRes = true
	slot0._levelId = slot1

	slot0:getCurScene():setCurLevelId(slot0._levelId)

	slot0._resPath = ResUrl.getExploreSceneLevelUrl(slot1)

	loadAbAsset(slot0._resPath, false, slot0._onLoadCallback, slot0)
end

return slot0
