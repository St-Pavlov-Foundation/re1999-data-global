module("modules.logic.scene.main.comp.MainSceneDirector", package.seeall)

slot0 = class("MainSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
	slot0.animSuccess = false
	slot0.switchSuccess = false
end

function slot0._onLevelLoaded(slot0)
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	WeatherController.instance:initSceneGo(slot0._scene.level:getSceneGo(), slot0._onSwitchResLoaded, slot0)
	slot0._scene.yearAnimation:initAnimationCurve(slot0._onAnimationCurveLoaded, slot0)
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
		slot0._scene:onPrepared()
	end
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
end

function slot0.onSceneClose(slot0)
	slot0.animSuccess = false
	slot0.switchSuccess = false

	MainController.instance:dispatchEvent(MainEvent.OnSceneClose)
	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView
	})
	WeatherController.instance:onSceneClose()
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

return slot0
