module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBuildingPlaceBlock", package.seeall)

slot0 = class("WaitGuideActionRoomBuildingPlaceBlock", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._sceneType = SceneType.Room
	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot0._buildingId = slot2[1]
	slot0._toastId = slot2[2]

	if GameSceneMgr.instance:getCurSceneType() == slot0._sceneType and not GameSceneMgr.instance:isLoading() then
		slot0:_check()
	else
		slot0:addEvents()
	end
end

function slot0._onEnterScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:_check()
	end
end

function slot0._check(slot0)
	if not GuideExceptionChecker.checkBuildingPut(nil, , slot0._buildingId) then
		slot0:onDone(true)
	else
		if slot0._toastId then
			GameFacade.showToast(slot0._toastId)
		end

		slot0:addEvents()
	end
end

function slot0.addEvents(slot0)
	if slot0.hasAddEvents then
		return
	end

	slot0.hasAddEvents = true

	GameSceneMgr.instance:registerCallback(slot0._sceneType, slot0._onEnterScene, slot0)
end

function slot0.removeEvents(slot0)
	if not slot0.hasAddEvents then
		return
	end

	slot0.hasAddEvents = false

	GameSceneMgr.instance:unregisterCallback(slot0._sceneType, slot0._onEnterScene, slot0)
end

function slot0.clearWork(slot0)
	slot0:removeEvents()
end

return slot0
