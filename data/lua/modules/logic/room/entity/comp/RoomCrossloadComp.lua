module("modules.logic.room.entity.comp.RoomCrossloadComp", package.seeall)

slot0 = class("RoomCrossloadComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._mo = slot0.entity:getMO()
	slot0._crossload = RoomBuildingEnum.Crossload[slot0._mo.buildingId]
	slot0._nextTime = 0
	slot0._durtion = 5
	slot0._isCanMove = true
	slot0._defaultAnimTime = 2.1
	slot0._animTime = 2.1

	slot0:reset()
end

function slot0.getCurResId(slot0)
	return slot0._curResId
end

function slot0.getCanMove(slot0)
	return slot0._isCanMove
end

function slot0.reset(slot0)
	slot0._curResId = nil

	if slot0:_canWork() then
		slot0:_runDelayInitAnim(3)
	end
end

function slot0._canWork(slot0)
	return RoomController.instance:isObMode() or RoomController.instance:isVisitMode()
end

function slot0.playAnim(slot0, slot1)
	if not slot0:_canWork() then
		return
	end

	if slot1 == slot0._curResId then
		if slot0._nextTime < Time.time + slot0._durtion then
			slot0._nextTime = slot2
		end

		return
	end

	if Time.time < slot0._nextTime then
		return
	end

	slot0:_playAnim(slot1)
	slot0:_runDelayInitAnim(slot0._animTime + slot0._durtion)
end

function slot0._runDelayInitAnim(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._playInitAnim, slot0)
	TaskDispatcher.runDelay(slot0._playInitAnim, slot0, slot1)
end

function slot0._playInitAnim(slot0)
	if slot0:_getInitResId() ~= slot0._curResId then
		slot0:_playAnim(slot1, slot0._curResId == nil)
	end
end

function slot0._playAnim(slot0, slot1, slot2)
	slot3, slot4, slot5 = slot0:_findAninNameByResId(slot1)

	if not slot3 then
		return
	end

	if slot0:_getAnimator() then
		slot0._isCanMove = slot0._curResId == slot1
		slot0._curResId = slot1
		slot0._animTime = slot4 or slot0._defineAnimTime

		slot0._animator:Play(slot3, 0, slot2 and 1 or 0)
		TaskDispatcher.cancelTask(slot0._delayOpenOrClose, slot0)
		TaskDispatcher.runDelay(slot0._delayOpenOrClose, slot0, slot0._animTime)

		slot0._nextTime = Time.time + slot0._durtion

		if not slot2 and slot5 and slot5 ~= 0 then
			slot0.entity:playAudio(slot5, slot0.go)
		end
	end
end

function slot0._delayOpenOrClose(slot0)
	if not RoomCrossLoadController.instance:isLock() then
		RoomCrossLoadController.instance:updatePathGraphic(slot0._mo.id)

		slot0._isCanMove = true
	else
		slot0._curResId = nil
	end
end

function slot0.addEventListeners(slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._onSwitchModel, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, slot0._onSwitchModel, slot0)
	TaskDispatcher.cancelTask(slot0._playInitAnim, slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenOrClose, slot0)
end

function slot0._onSwitchModel(slot0)
	slot0:reset()
end

function slot0._findAninNameByResId(slot0, slot1)
	if slot0._crossload and slot0._crossload.AnimStatus then
		for slot6, slot7 in ipairs(slot0._crossload.AnimStatus) do
			if slot7.resId == slot1 then
				return slot7.animName, slot7.animTime, slot7.audioId
			end
		end
	end
end

function slot0._getInitResId(slot0)
	if slot0._crossload and slot0._crossload.AnimStatus then
		return slot0._crossload.AnimStatus[1].resId
	end
end

function slot0._getAnimator(slot0)
	if not slot0._animator and slot0.entity:getBuildingGO() then
		slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	end

	return slot0._animator
end

function slot0.beforeDestroy(slot0)
	slot0._animator = nil

	slot0:removeEventListeners()
end

return slot0
