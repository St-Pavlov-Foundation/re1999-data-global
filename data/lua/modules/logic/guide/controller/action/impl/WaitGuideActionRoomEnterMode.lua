module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomEnterMode", package.seeall)

slot0 = class("WaitGuideActionRoomEnterMode", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot0._modeRequire = slot2[1]
	slot0._needEnterToTrigger = slot2[2] == 1

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._checkDone, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._checkDone, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, slot0._checkDone, slot0)

	if not slot0._needEnterToTrigger then
		slot0:_checkDone()
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._checkDone, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, slot0._checkDone, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, slot0._checkDone, slot0)
	GuidePriorityController.instance:remove(slot0.guideId)
end

function slot0._checkDone(slot0)
	if slot0:checkGuideLock() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot3 = false

		if slot0._modeRequire and RoomModel.instance:getGameMode() == slot0._modeRequire or RoomController.instance:isEditMode() then
			GuidePriorityController.instance:add(slot0.guideId, slot0._satisfyPriority, slot0, 0.01)
		end
	end
end

function slot0._satisfyPriority(slot0)
	slot0:onDone(true)
end

return slot0
