module("modules.logic.scene.newbie.comp.NewbieSceneLevelComp", package.seeall)

slot0 = class("NewbieSceneLevelComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0.animSuccess = false
	slot0.switchSuccess = false

	slot0:_loadMainScene(slot2, function ()
		uv0._scene:onPrepared()
	end)
end

function slot0._loadMainScene(slot0, slot1, slot2, slot3)
	slot0._callback = slot2
	slot0._callbackTarget = slot3

	if slot0._resPath then
		slot0:doCallback()

		return
	end

	slot0._levelId = slot1
	slot0._resPath = ResUrl.getSceneLevelUrl(slot0._levelId)

	loadAbAsset(slot0._resPath, false, slot0._onLoadCallback, slot0)
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._assetItem = slot1

		slot0._assetItem:Retain()

		slot0._instGO = gohelper.clone(slot0._assetItem:GetResource(slot0._resPath), GameSceneMgr.instance:getScene(SceneType.Main):getSceneContainerGO())

		WeatherController.instance:initSceneGo(slot0._instGO, slot0._onSwitchResLoaded, slot0)
		slot0._scene.yearAnimation:initAnimationCurve(slot0._onAnimationCurveLoaded, slot0)
		slot0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, slot0._levelId)
	end
end

function slot0._onAnimationCurveLoaded(slot0)
	slot0.animSuccess = true

	slot0:_check()
end

function slot0._onSwitchResLoaded(slot0)
	slot0.switchSuccess = true

	slot0:_check()
end

function slot0._check(slot0)
	if slot0.animSuccess and slot0.switchSuccess then
		slot0:doCallback()
	end
end

function slot0.doCallback(slot0)
	if slot0._callback then
		slot0._callback(slot0._callbackTarget)

		slot0._callback = nil
		slot0._callbackTarget = nil
	end
end

function slot0.onSceneClose(slot0)
	if slot0._assetItem then
		if slot0._instGO then
			gohelper.destroy(slot0._instGO)
		end

		slot0._assetItem:Release()

		slot0._assetItem = nil
	end

	slot0._resPath = nil
	slot0.animSuccess = false
	slot0.switchSuccess = false

	WeatherController.instance:onSceneClose()
end

function slot0._onLevelLoaded(slot0, slot1)
end

function slot0.getSceneGo(slot0)
	return slot0._instGO
end

return slot0
