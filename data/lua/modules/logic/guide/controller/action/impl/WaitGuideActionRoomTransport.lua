module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomTransport", package.seeall)

slot0 = class("WaitGuideActionRoomTransport", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._modeRequire = 2

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._checkDone, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._checkDone, slot0)

	slot0._goStepId = tonumber(slot0.actionParam)
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._checkDone, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, slot0._checkDone, slot0)
end

function slot0._checkDone(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot3 = false

		if slot0._modeRequire and RoomModel.instance:getGameMode() == slot0._modeRequire or RoomController.instance:isEditMode() then
			slot0:checkCondition()
		end
	end
end

function slot0.checkCondition(slot0)
	if GuideActionCondition.checkRoomTransport() then
		if GuideModel.instance:getById(slot0.guideId) then
			slot1.currStepId = slot0._goStepId - 1
		end

		slot0:onDone(true)
	end
end

return slot0
