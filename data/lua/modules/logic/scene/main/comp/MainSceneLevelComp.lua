module("modules.logic.scene.main.comp.MainSceneLevelComp", package.seeall)

slot0 = class("MainSceneLevelComp", CommonSceneLevelComp)

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
	MainSceneSwitchModel.instance:initSceneId()

	slot0._resPath = ResUrl.getSceneRes(MainSceneSwitchModel.instance:getCurSceneResName())

	loadAbAsset(slot0._resPath, false, slot0._onLoadCallback, slot0)
end

function slot0.switchLevel(slot0)
	slot0:loadLevel(slot0._levelId)
end

return slot0
